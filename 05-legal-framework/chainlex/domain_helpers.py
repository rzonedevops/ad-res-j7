#!/usr/bin/env python3
"""
ChainLex Domain-Specific Query Helpers

Provides specialized query functions for each legal domain, enabling
efficient and intuitive access to domain-specific concepts and rules.

Domains:
- Contract Law
- Criminal Law
- Constitutional Law
- Labour Law
- Administrative Law
- Environmental Law
- Construction Law
- International Law
- Delict (Tort) Law
- Property Law
"""

from typing import List, Dict, Any, Optional
from chainlex_api import ChainLex


class DomainQueryHelpers:
    """Domain-specific query helpers for optimal framework access"""
    
    def __init__(self, chainlex: ChainLex):
        self.chainlex = chainlex
    
    # Contract Law Helpers
    def contract_law(self) -> Dict[str, Any]:
        """Get comprehensive contract law information"""
        return {
            'principles': self.chainlex.principles.by_domain('contract'),
            'rules': self.chainlex.rules.by_domain('contract'),
            'key_concepts': self._search_concepts([
                'offer', 'acceptance', 'consideration', 'breach',
                'remedies', 'specific performance', 'damages'
            ], 'contract')
        }
    
    def contract_formation(self) -> List[Dict]:
        """Get rules about contract formation"""
        return self.chainlex.rules.search('formation', domain='contract')
    
    def contract_breach(self) -> List[Dict]:
        """Get rules about contract breach"""
        return self.chainlex.rules.search('breach', domain='contract')
    
    def contract_remedies(self) -> List[Dict]:
        """Get rules about contract remedies"""
        return self.chainlex.rules.search('remed', domain='contract')
    
    # Criminal Law Helpers
    def criminal_law(self) -> Dict[str, Any]:
        """Get comprehensive criminal law information"""
        return {
            'principles': self.chainlex.principles.by_domain('criminal'),
            'rules': self.chainlex.rules.by_domain('criminal'),
            'key_concepts': self._search_concepts([
                'actus reus', 'mens rea', 'murder', 'theft',
                'defense', 'intent', 'negligence'
            ], 'criminal')
        }
    
    def criminal_elements(self) -> List[Dict]:
        """Get rules about elements of crime"""
        results = []
        for term in ['actus-reus', 'mens-rea', 'causation']:
            results.extend(self.chainlex.rules.search(term, domain='criminal'))
        return results
    
    def criminal_defenses(self) -> List[Dict]:
        """Get rules about criminal defenses"""
        return self.chainlex.rules.search('defense', domain='criminal')
    
    def specific_crimes(self) -> Dict[str, List[Dict]]:
        """Get rules about specific crimes"""
        crimes = ['murder', 'theft', 'fraud', 'assault', 'robbery']
        return {
            crime: self.chainlex.rules.search(crime, domain='criminal')
            for crime in crimes
        }
    
    # Labour Law Helpers
    def labour_law(self) -> Dict[str, Any]:
        """Get comprehensive labour law information"""
        return {
            'principles': self.chainlex.principles.by_domain('labour'),
            'rules': self.chainlex.rules.by_domain('labour'),
            'key_concepts': self._search_concepts([
                'dismissal', 'unfair', 'strike', 'collective bargaining',
                'employment', 'workplace'
            ], 'labour')
        }
    
    def dismissal_law(self) -> List[Dict]:
        """Get rules about dismissal"""
        return self.chainlex.rules.search('dismissal', domain='labour')
    
    def strike_law(self) -> List[Dict]:
        """Get rules about strikes"""
        return self.chainlex.rules.search('strike', domain='labour')
    
    def employment_equity(self) -> List[Dict]:
        """Get rules about employment equity"""
        return self.chainlex.rules.search('equity', domain='labour')
    
    # Administrative Law Helpers
    def administrative_law(self) -> Dict[str, Any]:
        """Get comprehensive administrative law information"""
        return {
            'principles': self.chainlex.principles.by_domain('administrative'),
            'rules': self.chainlex.rules.by_domain('administrative'),
            'key_concepts': self._search_concepts([
                'PAJA', 'procedural fairness', 'judicial review',
                'rationality', 'lawful'
            ], 'administrative')
        }
    
    def paja_requirements(self) -> List[Dict]:
        """Get PAJA-related rules"""
        return self.chainlex.rules.search('paja', domain='administrative')
    
    def judicial_review(self) -> List[Dict]:
        """Get judicial review rules"""
        return self.chainlex.rules.search('review', domain='administrative')
    
    def procedural_fairness(self) -> List[Dict]:
        """Get procedural fairness rules"""
        return self.chainlex.rules.search('procedural', domain='administrative')
    
    # Environmental Law Helpers
    def environmental_law(self) -> Dict[str, Any]:
        """Get comprehensive environmental law information"""
        return {
            'principles': self.chainlex.principles.by_domain('environmental'),
            'rules': self.chainlex.rules.by_domain('environmental'),
            'key_concepts': self._search_concepts([
                'NEMA', 'EIA', 'pollution', 'biodiversity',
                'sustainable development', 'precautionary'
            ], 'environmental')
        }
    
    def eia_requirements(self) -> List[Dict]:
        """Get EIA-related rules"""
        return self.chainlex.rules.search('eia', domain='environmental')
    
    def pollution_control(self) -> List[Dict]:
        """Get pollution control rules"""
        return self.chainlex.rules.search('pollution', domain='environmental')
    
    def biodiversity_law(self) -> List[Dict]:
        """Get biodiversity rules"""
        return self.chainlex.rules.search('biodiversity', domain='environmental')
    
    # Construction Law Helpers
    def construction_law(self) -> Dict[str, Any]:
        """Get comprehensive construction law information"""
        return {
            'principles': self.chainlex.principles.by_domain('construction'),
            'rules': self.chainlex.rules.by_domain('construction'),
            'key_concepts': self._search_concepts([
                'JBCC', 'FIDIC', 'contractor', 'employer',
                'variation', 'defect', 'claim'
            ], 'construction')
        }
    
    def contract_types(self) -> Dict[str, List[Dict]]:
        """Get rules about different contract types"""
        types = ['JBCC', 'FIDIC', 'NEC', 'GCC']
        return {
            contract_type: self.chainlex.rules.search(contract_type, domain='construction')
            for contract_type in types
        }
    
    def claims_and_variations(self) -> List[Dict]:
        """Get rules about claims and variations"""
        results = []
        for term in ['claim', 'variation']:
            results.extend(self.chainlex.rules.search(term, domain='construction'))
        return results
    
    def defects_law(self) -> List[Dict]:
        """Get rules about defects"""
        return self.chainlex.rules.search('defect', domain='construction')
    
    # International Law Helpers
    def international_law(self) -> Dict[str, Any]:
        """Get comprehensive international law information"""
        return {
            'principles': self.chainlex.principles.by_domain('international'),
            'rules': self.chainlex.rules.by_domain('international'),
            'key_concepts': self._search_concepts([
                'treaty', 'customary', 'jurisdiction', 'sovereignty',
                'diplomatic', 'ICC'
            ], 'international')
        }
    
    def treaty_law(self) -> List[Dict]:
        """Get rules about treaties"""
        return self.chainlex.rules.search('treaty', domain='international')
    
    def customary_law(self) -> List[Dict]:
        """Get rules about customary international law"""
        return self.chainlex.rules.search('customary', domain='international')
    
    def jurisdiction_rules(self) -> List[Dict]:
        """Get rules about jurisdiction"""
        return self.chainlex.rules.search('jurisdiction', domain='international')
    
    # Constitutional Law Helpers
    def constitutional_law(self) -> Dict[str, Any]:
        """Get comprehensive constitutional law information"""
        return {
            'principles': self.chainlex.principles.by_domain('constitutional'),
            'rules': self.chainlex.rules.by_domain('constitutional'),
            'key_concepts': self._search_concepts([
                'bill of rights', 'equality', 'dignity', 'freedom',
                'limitation', 'proportionality'
            ], 'constitutional')
        }
    
    def bill_of_rights(self) -> List[Dict]:
        """Get Bill of Rights rules"""
        return self.chainlex.rules.search('right', domain='constitutional')
    
    def limitations_clause(self) -> List[Dict]:
        """Get limitation clause rules"""
        return self.chainlex.rules.search('limitation', domain='constitutional')
    
    # Delict (Tort) Law Helpers
    def delict_law(self) -> Dict[str, Any]:
        """Get comprehensive delict law information"""
        return {
            'principles': self.chainlex.principles.by_domain('delict'),
            'rules': self.chainlex.rules.by_domain('delict'),
            'key_concepts': self._search_concepts([
                'wrongfulness', 'fault', 'causation', 'damages',
                'negligence', 'defamation'
            ], 'delict')
        }
    
    def delict_elements(self) -> List[Dict]:
        """Get rules about elements of delict"""
        results = []
        for term in ['wrongful', 'fault', 'causation', 'damage']:
            results.extend(self.chainlex.rules.search(term, domain='delict'))
        return results
    
    def negligence_law(self) -> List[Dict]:
        """Get negligence rules"""
        return self.chainlex.rules.search('negligence', domain='delict')
    
    # Property Law Helpers
    def property_law(self) -> Dict[str, Any]:
        """Get comprehensive property law information"""
        return {
            'principles': self.chainlex.principles.by_domain('property'),
            'rules': self.chainlex.rules.by_domain('property'),
            'key_concepts': self._search_concepts([
                'ownership', 'possession', 'transfer', 'real rights',
                'servitude', 'mortgage'
            ], 'property')
        }
    
    def ownership_rules(self) -> List[Dict]:
        """Get ownership rules"""
        return self.chainlex.rules.search('ownership', domain='property')
    
    def real_rights(self) -> List[Dict]:
        """Get real rights rules"""
        return self.chainlex.rules.search('real', domain='property')
    
    # Utility Methods
    def _search_concepts(self, concepts: List[str], domain: str) -> Dict[str, List[Dict]]:
        """Search for multiple concepts in a domain"""
        results = {}
        for concept in concepts:
            matches = self.chainlex.rules.search(concept, domain=domain)
            if matches:
                results[concept] = matches
        return results
    
    def quick_lookup(self, topic: str) -> Dict[str, Any]:
        """
        Quick lookup by topic name
        
        Args:
            topic: Topic name (e.g., 'contract', 'criminal', 'labour')
        
        Returns:
            Dictionary with relevant information
        """
        topic_map = {
            'contract': self.contract_law,
            'criminal': self.criminal_law,
            'labour': self.labour_law,
            'administrative': self.administrative_law,
            'environmental': self.environmental_law,
            'construction': self.construction_law,
            'international': self.international_law,
            'constitutional': self.constitutional_law,
            'delict': self.delict_law,
            'property': self.property_law
        }
        
        handler = topic_map.get(topic.lower())
        if handler:
            return handler()
        else:
            return {'error': f'Unknown topic: {topic}'}


def main():
    """Demo of domain-specific query helpers"""
    from chainlex_api import ChainLex
    
    print("Initializing ChainLex with domain helpers...")
    chainlex = ChainLex()
    helpers = DomainQueryHelpers(chainlex)
    
    print("\n" + "="*70)
    print("Example 1: Contract Law Quick Lookup")
    print("="*70)
    contract_info = helpers.contract_law()
    print(f"Principles: {len(contract_info['principles'])}")
    print(f"Rules: {len(contract_info['rules'])}")
    print(f"Key concepts: {len(contract_info['key_concepts'])}")
    
    print("\n" + "="*70)
    print("Example 2: Criminal Law - Specific Crimes")
    print("="*70)
    crimes = helpers.specific_crimes()
    for crime, rules in crimes.items():
        print(f"{crime}: {len(rules)} rules")
    
    print("\n" + "="*70)
    print("Example 3: Labour Law - Dismissal")
    print("="*70)
    dismissal_rules = helpers.dismissal_law()
    print(f"Found {len(dismissal_rules)} dismissal rules")
    for rule in dismissal_rules[:3]:
        print(f"  - {rule['name']}")
    
    print("\n" + "="*70)
    print("Example 4: Quick Topic Lookup")
    print("="*70)
    env_info = helpers.quick_lookup('environmental')
    print(f"Environmental Law:")
    print(f"  Principles: {len(env_info['principles'])}")
    print(f"  Rules: {len(env_info['rules'])}")
    
    print("\n" + "="*70)


if __name__ == "__main__":
    main()
