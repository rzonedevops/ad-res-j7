#!/usr/bin/env python3
"""
ChainLex Helper Modules Demonstration
======================================

This script demonstrates the usage of the newly implemented domain-specific
helper modules for legal reasoning.
"""

from framework_index import FrameworkIndex

def print_section(title):
    """Print a formatted section header"""
    print("\n" + "=" * 70)
    print(f"  {title}")
    print("=" * 70 + "\n")

def demonstrate_helper_modules():
    """Demonstrate the new helper modules"""
    
    print_section("ChainLex Domain-Specific Helper Modules")
    
    # Initialize framework index
    index = FrameworkIndex()
    
    # Show helper module statistics
    print_section("Helper Modules Statistics")
    
    helper_modules = {
        'Criminal Law': 'criminal_law_helpers.scm',
        'Property Law': 'property_law_helpers.scm',
        'Labour Law': 'labour_law_helpers.scm',
        'Administrative Law': 'administrative_law_helpers.scm',
        'Environmental Law': 'environmental_law_helpers.scm',
        'Construction Law': 'construction_law_helpers.scm',
        'Contract Law': 'contract_law_helpers.scm',
        'Delict Law': 'delict_law_helpers.scm',
        'Core Utilities': 'core_utilities.scm'
    }
    
    print("📚 Available Helper Modules:\n")
    for domain, filename in helper_modules.items():
        print(f"   • {domain:25} → lv1/{filename}")
    
    # Show helper functions by domain
    print_section("Helper Functions by Legal Domain")
    
    domains_to_check = [
        ('criminal', 'Criminal Law'),
        ('property', 'Property Law'),
        ('labour', 'Labour Law'),
        ('administrative', 'Administrative Law'),
        ('environmental', 'Environmental Law'),
        ('construction', 'Construction Law')
    ]
    
    for domain_key, domain_name in domains_to_check:
        results = index.search_functions(domain_key, domain=domain_key)
        if results:
            print(f"🏛️  {domain_name} Helpers: {len(results)} functions")
            print(f"   Examples:")
            for func in results[:5]:  # Show first 5
                print(f"   • {func['name']}")
            if len(results) > 5:
                print(f"   ... and {len(results) - 5} more")
            print()
    
    # Show cross-references
    print_section("Level 1 Principle Cross-References")
    
    key_principles = [
        'pacta-sunt-servanda',
        'actus-non-facit-reum-nisi-mens-sit-rea',
        'nemo-dat-quod-non-habet',
        'audi-alteram-partem',
        'legality'
    ]
    
    print("🔗 Helper functions derived from key principles:\n")
    for principle in key_principles:
        derived = index.find_derived_rules(principle)
        if derived:
            print(f"   {principle}:")
            for rule in derived[:3]:  # Show first 3
                print(f"   • {rule['name']}")
            if len(derived) > 3:
                print(f"   ... and {len(derived) - 3} more")
            print()
    
    # Show usage examples
    print_section("Usage Examples")
    
    examples = [
        {
            'title': 'Criminal Law: Check mens rea',
            'code': """
from chainlex.criminal_law_helpers import mens-rea?, intention?

act = {
    'intention-type': 'dolus-directus',
    'desired-result': True,
    'knew-would-occur': True
}

if mens-rea?(act):
    print("Guilty mind (mens rea) established")
"""
        },
        {
            'title': 'Property Law: Validate transfer',
            'code': """
from chainlex.property_law_helpers import valid-transfer?

transfer = {
    'transferor': {'capacity': True, 'ownership': True},
    'transferee': {'capacity': True, 'age': 25},
    'delivered': True,
    'property': {'illegal': False}
}

if valid-transfer?(transfer):
    print("Property transfer is valid")
"""
        },
        {
            'title': 'Labour Law: Check fair dismissal',
            'code': """
from chainlex.labour_law_helpers import fair-dismissal?

dismissal = {
    'reason': 'misconduct',
    'serious-misconduct': True,
    'investigation-conducted': True,
    'employee-notified': True,
    'opportunity-to-respond': True,
    'hearing-held': True
}

if fair-dismissal?(dismissal):
    print("Dismissal was fair")
"""
        }
    ]
    
    for example in examples:
        print(f"📝 {example['title']}\n")
        print(example['code'])
        print()
    
    # Show implementation statistics
    print_section("Implementation Statistics")
    
    stats = index.get_framework_stats()
    
    print(f"📊 Overall Statistics:\n")
    print(f"   Total Functions:      {stats['total_functions']:>6}")
    print(f"   Total Principles:     {stats['total_principles']:>6}")
    print(f"   Total Frameworks:     {stats['total_frameworks']:>6}")
    print()
    
    # Calculate helper module stats
    helper_functions = 0
    for domain_key, _ in domains_to_check:
        results = index.search_functions(domain_key, domain=domain_key)
        helper_functions += len(results)
    
    print(f"📈 Helper Module Contributions:\n")
    print(f"   Helper Functions:     {helper_functions:>6}")
    print(f"   Helper Modules:       {len(helper_modules):>6}")
    print(f"   Coverage:             {len(domains_to_check):>6} major domains")
    print()
    
    # Show completion status
    print_section("Implementation Completion Status")
    
    phases = [
        ('Phase 1: Core Infrastructure', '✅ Complete', [
            'core_utilities.scm - 50+ functions',
            'contract_law_helpers.scm - 25+ functions',
            'delict_law_helpers.scm - 20+ functions'
        ]),
        ('Phase 2: Domain Helpers', '✅ Complete', [
            'criminal_law_helpers.scm - 28 functions',
            'property_law_helpers.scm - 25 functions',
            'labour_law_helpers.scm - 42 functions',
            'administrative_law_helpers.scm - 22 functions',
            'environmental_law_helpers.scm - 20 functions',
            'construction_law_helpers.scm - 28 functions'
        ]),
        ('Phase 3: Integration', '📋 Planned', [
            'Update framework files to use helpers',
            'Replace placeholder implementations',
            'Add comprehensive test coverage'
        ]),
        ('Phase 4: Testing & Validation', '📋 Planned', [
            'Unit tests for all helpers',
            'Integration tests for legal scenarios',
            'Confidence computation validation'
        ])
    ]
    
    for phase_name, status, items in phases:
        print(f"{status} {phase_name}")
        for item in items:
            print(f"         • {item}")
        print()
    
    # Show next steps
    print_section("Next Steps")
    
    print("""
🎯 Recommended Actions:

1. Integration Testing
   • Test helper functions with real legal scenarios
   • Verify cross-references to Level 1 principles
   • Validate inference chain computation

2. Documentation
   • Add usage examples for each helper module
   • Create legal reasoning walkthroughs
   • Update API documentation

3. Framework Enhancement
   • Update existing .scm files to import helpers
   • Replace placeholder calls with helper functions
   • Add missing logic where helpers don't exist

4. Hypergraph Integration
   • Rebuild hypergraph with new helper relationships
   • Add derivation edges from principles to helpers
   • Update visualization tools

5. Performance Optimization
   • Profile helper function execution
   • Optimize frequently-used operations
   • Cache common legal determinations

6. Extended Coverage
   • Implement remaining placeholder functions
   • Add more specific crime helpers
   • Expand property acquisition methods
    """)

if __name__ == '__main__':
    demonstrate_helper_modules()
