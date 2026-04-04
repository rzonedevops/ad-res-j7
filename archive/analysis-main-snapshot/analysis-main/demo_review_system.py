#!/usr/bin/env python3
"""
Demonstration of the Affidavit Review System

This script demonstrates the critical evidence update review system
that was implemented to address the GitHub issue.
"""

import sys
from pathlib import Path
import logging

# Add src to path
sys.path.insert(0, str(Path(__file__).parent / 'src'))

from affidavit_enhancement.affidavit_processor import AffidavitProcessor

def main():
    """Demonstrate the review system functionality"""
    
    # Set up logging
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    
    print("🚨 CRITICAL EVIDENCE UPDATE REVIEW SYSTEM DEMO")
    print("=" * 50)
    
    # Initialize processor
    processor = AffidavitProcessor()
    
    # Analyze current state
    print("\n📊 Analyzing current evidence and affidavits...")
    affidavits = processor.discover_affidavits()
    updates = processor.analyze_evidence_changes()
    
    print(f"📋 Found {len(affidavits)} affidavit files")
    print(f"📈 Found {len(updates)} evidence updates")
    
    # Count critical and high priority updates
    critical_count = sum(1 for u in updates if u.priority == 'critical')
    high_count = sum(1 for u in updates if u.priority == 'high')
    
    print(f"🔥 Critical Updates: {critical_count}")
    print(f"⚠️  High Priority Updates: {high_count}")
    
    # Generate review summary report to show what would be alerted
    print("\n📄 Generating Review Alert Report...")
    print("=" * 50)
    
    # Create some sample review statuses to demonstrate the system
    from affidavit_enhancement.affidavit_processor import ReviewStatus
    
    # Simulate review statuses for demonstration
    processor.review_statuses = {}
    
    if critical_count > 0 or high_count > 0:
        # Create a sample review status for the first affidavit
        if affidavits:
            sample_affidavit = affidavits[0]
            enhanced_path = processor.output_dir / f"{sample_affidavit.stem}_enhanced{sample_affidavit.suffix}"
            
            review_status = ReviewStatus(
                affidavit_path=str(sample_affidavit),
                enhanced_path=str(enhanced_path),
                critical_updates=min(critical_count, 5),  # Cap for demo
                high_priority_updates=min(high_count, 10),  # Cap for demo
                total_updates=min(len(updates), 20),  # Cap for demo
                requires_review=True
            )
            
            processor.review_statuses[str(sample_affidavit)] = review_status
            
            # Generate alert
            alert = processor._generate_review_alert(review_status)
            print(alert)
    
    # Generate comprehensive review summary
    summary_report = processor.generate_review_summary_report()
    
    # Save the report
    report_path = Path("CRITICAL_EVIDENCE_REVIEW_ALERT.md")
    report_path.write_text(summary_report)
    
    print(f"\n📄 Critical review alert saved to: {report_path}")
    
    # Show pending reviews
    print("\n📋 REVIEW SYSTEM STATUS:")
    print("=" * 30)
    
    if processor.review_statuses:
        print("🚨 DOCUMENTS REQUIRING LEGAL REVIEW:")
        for affidavit_path, review_status in processor.review_statuses.items():
            print(f"   - {Path(affidavit_path).name}")
            print(f"     Critical Updates: {review_status.critical_updates}")
            print(f"     High Priority Updates: {review_status.high_priority_updates}")
            print(f"     Status: {review_status.approval_status.upper()}")
            print(f"     Ready for Filing: {'✅ YES' if review_status.ready_for_filing else '❌ NO'}")
    else:
        print("✅ No documents currently require review")
    
    print("\n🎯 NEXT STEPS:")
    print("1. Review enhanced affidavits for accuracy")
    print("2. Validate legal compliance")
    print("3. Approve changes before filing")
    print("4. Mark reviews as complete")
    print("5. Only file documents after legal approval")
    
    print(f"\n📁 Files are organized as follows:")
    print(f"   Enhanced Affidavits: {processor.output_dir}")
    print(f"   Original Backups: {processor.backup_dir}")
    print(f"   Review Status Files: {processor.review_dir}")

if __name__ == "__main__":
    main()