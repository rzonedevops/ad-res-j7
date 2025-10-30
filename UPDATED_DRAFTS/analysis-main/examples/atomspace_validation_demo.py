#!/usr/bin/env python3
"""
AtomSpace Validation Demo
=========================

Demonstrates the defensive validation added to AtomSpace constructor
to prevent SSR (Server-Side Rendering) errors and ensure proper initialization.
"""

import sys
from pathlib import Path

# Add parent directory to path
sys.path.insert(0, str(Path(__file__).parent.parent))

from frameworks.opencog_hgnnql import AtomSpace


def print_section(title: str):
    """Print a section header"""
    print("\n" + "=" * 70)
    print(f"  {title}")
    print("=" * 70)


def demo_correct_usage():
    """Demonstrate correct AtomSpace initialization"""
    print_section("✅ CORRECT USAGE - AtomSpace with case_id")
    
    print("\nExample 1: Basic initialization")
    print("Code: atomspace = AtomSpace(case_id='case_2025_001')")
    try:
        atomspace = AtomSpace(case_id="case_2025_001")
        print(f"✅ Success! Created AtomSpace for case: {atomspace.case_id}")
        print(f"   Atoms in space: {len(atomspace.atoms)}")
    except Exception as e:
        print(f"❌ Error: {e}")
    
    print("\nExample 2: SSR backend initialization")
    print("Code: atomspace = AtomSpace(case_id=request.case_id)")
    try:
        # Simulating backend request context
        class MockRequest:
            case_id = "backend_case_12345"
        
        request = MockRequest()
        atomspace = AtomSpace(case_id=request.case_id)
        print(f"✅ Success! Created AtomSpace for case: {atomspace.case_id}")
    except Exception as e:
        print(f"❌ Error: {e}")
    
    print("\nExample 3: API endpoint initialization")
    print("Code: atomspace = AtomSpace(case_id=data.get('case_id'))")
    try:
        # Simulating API request data
        data = {"case_id": "api_case_67890"}
        atomspace = AtomSpace(case_id=data.get("case_id"))
        print(f"✅ Success! Created AtomSpace for case: {atomspace.case_id}")
    except Exception as e:
        print(f"❌ Error: {e}")


def demo_incorrect_usage():
    """Demonstrate incorrect AtomSpace initialization with helpful error messages"""
    print_section("❌ INCORRECT USAGE - Common Mistakes and Error Messages")
    
    print("\nMistake 1: Missing case_id parameter")
    print("Code: atomspace = AtomSpace()")
    try:
        atomspace = AtomSpace()  # This will fail
        print(f"✅ Success (unexpected)")
    except TypeError as e:
        print(f"❌ TypeError caught (expected): {e}")
        print("   → Fix: Provide case_id parameter")
    
    print("\nMistake 2: None as case_id")
    print("Code: atomspace = AtomSpace(case_id=None)")
    try:
        atomspace = AtomSpace(case_id=None)  # This will fail
        print(f"✅ Success (unexpected)")
    except ValueError as e:
        print(f"❌ ValueError caught (expected):")
        print(f"   {e}")
        print("   → Fix: Provide a valid case_id string")
    
    print("\nMistake 3: Empty string as case_id")
    print("Code: atomspace = AtomSpace(case_id='')")
    try:
        atomspace = AtomSpace(case_id="")  # This will fail
        print(f"✅ Success (unexpected)")
    except ValueError as e:
        print(f"❌ ValueError caught (expected):")
        print(f"   {e}")
        print("   → Fix: Provide a non-empty case_id string")
    
    print("\nMistake 4: Whitespace-only case_id")
    print("Code: atomspace = AtomSpace(case_id='   ')")
    try:
        atomspace = AtomSpace(case_id="   ")  # This will fail
        print(f"✅ Success (unexpected)")
    except ValueError as e:
        print(f"❌ ValueError caught (expected):")
        print(f"   {e}")
        print("   → Fix: Provide a non-empty case_id string")
    
    print("\nMistake 5: Wrong type (integer) as case_id")
    print("Code: atomspace = AtomSpace(case_id=123)")
    try:
        atomspace = AtomSpace(case_id=123)  # This will fail
        print(f"✅ Success (unexpected)")
    except TypeError as e:
        print(f"❌ TypeError caught (expected):")
        print(f"   {e}")
        print("   → Fix: Provide case_id as a string")
    
    print("\nMistake 6: Wrong type (list) as case_id")
    print("Code: atomspace = AtomSpace(case_id=['case', 'id'])")
    try:
        atomspace = AtomSpace(case_id=["case", "id"])  # This will fail
        print(f"✅ Success (unexpected)")
    except TypeError as e:
        print(f"❌ TypeError caught (expected):")
        print(f"   {e}")
        print("   → Fix: Provide case_id as a string")


def demo_ssr_best_practices():
    """Demonstrate SSR best practices"""
    print_section("🎯 SSR BEST PRACTICES")
    
    print("\n1. Always validate backend object construction parameters")
    print("   ✓ Check that case_id exists before passing to AtomSpace")
    print("   ✓ Use defensive coding patterns")
    
    print("\n2. Example: Defensive backend initialization")
    print("""
    def create_atomspace_from_request(request):
        case_id = request.get('case_id')
        
        # Validate before creating AtomSpace
        if not case_id or not isinstance(case_id, str):
            raise ValueError("Valid case_id required")
        
        return AtomSpace(case_id=case_id)
    """)
    
    print("\n3. Example: API endpoint with validation")
    print("""
    @app.route('/api/cases/<case_id>/analyze', methods=['POST'])
    def analyze_case(case_id: str):
        try:
            # AtomSpace will validate case_id
            atomspace = AtomSpace(case_id=case_id)
            # ... perform analysis ...
            return jsonify({'success': True})
        except (ValueError, TypeError) as e:
            return jsonify({'error': str(e)}), 400
    """)
    
    print("\n4. Key Takeaways:")
    print("   ✓ AtomSpace requires case_id for proper SSR initialization")
    print("   ✓ Defensive validation catches errors early")
    print("   ✓ Clear error messages guide developers to fixes")
    print("   ✓ Use try-except blocks for robust error handling")


def main():
    """Main demo function"""
    print("\n" + "🧠" * 35)
    print("  AtomSpace Validation Demo")
    print("  Defensive Programming for SSR Safety")
    print("🧠" * 35)
    
    # Run demos
    demo_correct_usage()
    demo_incorrect_usage()
    demo_ssr_best_practices()
    
    print("\n" + "=" * 70)
    print("  ✓ Demo completed successfully!")
    print("=" * 70)
    print("\nKey Points:")
    print("  1. AtomSpace requires case_id parameter")
    print("  2. Defensive validation prevents SSR runtime errors")
    print("  3. Clear error messages enable quick debugging")
    print("  4. All existing code continues to work")
    print("\n")


if __name__ == "__main__":
    main()
