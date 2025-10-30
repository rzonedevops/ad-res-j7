#!/usr/bin/env python3
"""
Affidavit Review Management Tool

This tool helps legal reviewers manage the review and approval process
for affidavits that have been enhanced with critical evidence updates.
"""

import argparse
import json
import logging
import sys
from datetime import datetime
from pathlib import Path

# Add src to path
sys.path.insert(0, str(Path(__file__).parent.parent / 'src'))

from affidavit_enhancement.affidavit_processor import AffidavitProcessor, ReviewStatus


def setup_logging(verbose: bool = False):
    """Set up logging configuration"""
    level = logging.DEBUG if verbose else logging.INFO
    format_str = '%(asctime)s - %(levelname)s - %(message)s'
    
    logging.basicConfig(
        level=level,
        format=format_str,
        handlers=[logging.StreamHandler(sys.stdout)]
    )


def list_pending_reviews(processor: AffidavitProcessor):
    """List all pending reviews"""
    pending_reviews = processor.get_pending_reviews()
    
    if not pending_reviews:
        print("✅ No affidavits currently require review")
        return
        
    print(f"📋 Found {len(pending_reviews)} documents requiring legal review:\n")
    
    for i, review in enumerate(pending_reviews, 1):
        print(f"{i}. {Path(review.affidavit_path).name}")
        print(f"   Enhanced File: {Path(review.enhanced_path).name}")
        print(f"   Critical Updates: {review.critical_updates}")
        print(f"   High Priority Updates: {review.high_priority_updates}")
        print(f"   Total Updates: {review.total_updates}")
        print(f"   Status: {review.approval_status.upper()}")
        print(f"   Ready for Filing: {'✅ YES' if review.ready_for_filing else '❌ NO'}")
        print()


def review_document(processor: AffidavitProcessor, affidavit_name: str, reviewer: str):
    """Interactive review of a document"""
    # Find the review status file
    review_file = processor.review_dir / f"{Path(affidavit_name).stem}_review_status.json"
    
    if not review_file.exists():
        print(f"❌ Review file not found for {affidavit_name}")
        return
        
    # Load review status
    with open(review_file, 'r') as f:
        status_dict = json.load(f)
    
    review_status = ReviewStatus(**status_dict)
    
    print(f"\n📄 Reviewing: {Path(review_status.affidavit_path).name}")
    print("=" * 50)
    print(f"Enhanced File: {Path(review_status.enhanced_path).name}")
    print(f"Critical Updates: {review_status.critical_updates}")
    print(f"High Priority Updates: {review_status.high_priority_updates}")
    print(f"Total Updates: {review_status.total_updates}")
    print(f"Current Status: {review_status.approval_status.upper()}")
    
    # Show the enhanced file if it exists
    enhanced_path = Path(review_status.enhanced_path)
    if enhanced_path.exists():
        print(f"\n📖 Enhanced Document Location: {enhanced_path}")
        print("You should review this file before making a decision.")
    else:
        print(f"⚠️  Enhanced file not found at: {enhanced_path}")
    
    print("\n🎯 Review Options:")
    print("1. Approve for filing")
    print("2. Reject (needs revision)")
    print("3. Mark as needs revision")
    print("4. Cancel review")
    
    while True:
        choice = input("\nSelect option (1-4): ").strip()
        
        if choice == "1":
            approval_status = "approved"
            break
        elif choice == "2":
            approval_status = "rejected"
            break
        elif choice == "3":
            approval_status = "needs_revision"
            break
        elif choice == "4":
            print("Review cancelled")
            return
        else:
            print("Invalid choice. Please select 1-4.")
    
    # Get review comments
    comments = input("\nEnter review comments (optional): ").strip()
    
    # Complete the review
    success = processor.mark_review_complete(
        review_status.affidavit_path,
        reviewer,
        approval_status,
        comments
    )
    
    if success:
        status_text = "APPROVED FOR FILING" if approval_status == "approved" else approval_status.upper()
        print(f"\n✅ Review completed: {status_text}")
        if approval_status == "approved":
            print("🎯 Document is now ready for filing")
        else:
            print("⚠️  Document requires further action before filing")
    else:
        print("\n❌ Failed to complete review")


def approve_document(processor: AffidavitProcessor, affidavit_name: str, reviewer: str, comments: str = ""):
    """Approve a document for filing"""
    success = processor.mark_review_complete(affidavit_name, reviewer, "approved", comments)
    
    if success:
        print(f"✅ Approved {affidavit_name} for filing")
    else:
        print(f"❌ Failed to approve {affidavit_name}")


def reject_document(processor: AffidavitProcessor, affidavit_name: str, reviewer: str, comments: str = ""):
    """Reject a document"""
    success = processor.mark_review_complete(affidavit_name, reviewer, "rejected", comments)
    
    if success:
        print(f"❌ Rejected {affidavit_name}")
    else:
        print(f"❌ Failed to reject {affidavit_name}")


def generate_status_report(processor: AffidavitProcessor):
    """Generate a comprehensive status report"""
    pending_reviews = processor.get_pending_reviews()
    
    # Also check for completed reviews
    all_review_files = list(processor.review_dir.glob("*_review_status.json"))
    completed_reviews = []
    
    for review_file in all_review_files:
        with open(review_file, 'r') as f:
            status_dict = json.load(f)
        
        status = ReviewStatus(**status_dict)
        if status.review_completed:
            completed_reviews.append(status)
    
    report = f"""# Affidavit Review Status Report

**Generated**: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}

## Summary

- **Pending Reviews**: {len(pending_reviews)}
- **Completed Reviews**: {len(completed_reviews)}
- **Total Reviews**: {len(all_review_files)}

## Pending Reviews

"""
    
    if pending_reviews:
        for review in pending_reviews:
            report += f"""### {Path(review.affidavit_path).name}

- **Enhanced File**: `{Path(review.enhanced_path).name}`
- **Critical Updates**: {review.critical_updates}
- **High Priority Updates**: {review.high_priority_updates}
- **Total Updates**: {review.total_updates}
- **Status**: {review.approval_status.upper()}
- **Ready for Filing**: {'✅ YES' if review.ready_for_filing else '❌ NO'}

"""
    else:
        report += "✅ No pending reviews\n\n"
    
    report += "## Completed Reviews\n\n"
    
    if completed_reviews:
        approved = [r for r in completed_reviews if r.approval_status == "approved"]
        rejected = [r for r in completed_reviews if r.approval_status == "rejected"]
        revision = [r for r in completed_reviews if r.approval_status == "needs_revision"]
        
        report += f"- **Approved**: {len(approved)}\n"
        report += f"- **Rejected**: {len(rejected)}\n"
        report += f"- **Needs Revision**: {len(revision)}\n\n"
        
        for review in completed_reviews:
            status_icon = {
                "approved": "✅",
                "rejected": "❌", 
                "needs_revision": "⚠️"
            }.get(review.approval_status, "❓")
            
            report += f"### {status_icon} {Path(review.affidavit_path).name}\n\n"
            report += f"- **Status**: {review.approval_status.upper()}\n"
            report += f"- **Reviewer**: {review.reviewer}\n"
            report += f"- **Review Date**: {review.review_date}\n"
            if review.review_comments:
                report += f"- **Comments**: {review.review_comments}\n"
            report += f"- **Ready for Filing**: {'✅ YES' if review.ready_for_filing else '❌ NO'}\n\n"
    else:
        report += "No completed reviews\n\n"
    
    report += "---\n\n*Generated by Affidavit Review Management Tool*\n"
    
    return report


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description="Manage affidavit reviews for critical evidence updates",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # List all pending reviews
  python scripts/manage_affidavit_reviews.py --list
  
  # Interactive review of a specific document
  python scripts/manage_affidavit_reviews.py --review "my_affidavit.md" --reviewer "John Smith"
  
  # Approve a document
  python scripts/manage_affidavit_reviews.py --approve "my_affidavit.md" --reviewer "John Smith" --comments "Reviewed and approved"
  
  # Generate status report
  python scripts/manage_affidavit_reviews.py --status-report
        """
    )
    
    parser.add_argument("--list", action="store_true", help="List all pending reviews")
    parser.add_argument("--review", help="Interactively review a specific document")
    parser.add_argument("--approve", help="Approve a document for filing")
    parser.add_argument("--reject", help="Reject a document")
    parser.add_argument("--reviewer", help="Name of the reviewer", required=False)
    parser.add_argument("--comments", help="Review comments", default="")
    parser.add_argument("--status-report", action="store_true", help="Generate comprehensive status report")
    parser.add_argument("--config", help="Path to configuration file")
    parser.add_argument("--verbose", "-v", action="store_true", help="Verbose logging")
    
    args = parser.parse_args()
    
    # Set up logging
    setup_logging(args.verbose)
    
    # Initialize processor
    processor = AffidavitProcessor(args.config)
    
    try:
        if args.list:
            print("📋 PENDING AFFIDAVIT REVIEWS")
            print("=" * 40)
            list_pending_reviews(processor)
            
        elif args.review:
            if not args.reviewer:
                print("❌ Reviewer name is required for interactive review")
                sys.exit(1)
            review_document(processor, args.review, args.reviewer)
            
        elif args.approve:
            if not args.reviewer:
                print("❌ Reviewer name is required for approval")
                sys.exit(1)
            approve_document(processor, args.approve, args.reviewer, args.comments)
            
        elif args.reject:
            if not args.reviewer:
                print("❌ Reviewer name is required for rejection")
                sys.exit(1)
            reject_document(processor, args.reject, args.reviewer, args.comments)
            
        elif args.status_report:
            print("📊 Generating comprehensive status report...")
            report = generate_status_report(processor)
            
            report_path = Path("AFFIDAVIT_REVIEW_STATUS_REPORT.md")
            report_path.write_text(report)
            
            print(f"📄 Status report saved to: {report_path}")
            
        else:
            parser.print_help()
            
    except KeyboardInterrupt:
        print("\n⏹️ Operation cancelled by user")
        sys.exit(1)
    except Exception as e:
        logging.error(f"❌ Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()