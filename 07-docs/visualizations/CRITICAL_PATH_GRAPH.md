
# Critical Path Dependencies - Mermaid Diagram

```mermaid
graph TD
    %% Foundation Layer
    subgraph foundation[Foundation Layer - Week 1-2]
        SEC[#2771 Security Fix]
        ISS[#2774 Issue Creation]
        BAT[#2776 Batching]
        
        BANK[#2838 R500K Statement]
        LOAN[#2836 Director Loans]
        RP[#2834 Responsible Person<br/>37 jurisdictions<br/>⚠️ 4-6 weeks]
        WIT[#2837 Peter Withdrawals]
        REG[#2835 Regulatory Risk]
        
        CHES[#2841 Chesno Fraud]
    end
    
    %% Integration Layer - Evidence Index
    subgraph evidence[Evidence Index Chain - Week 3-4]
        IDX[#2855 Evidence Index<br/>275+ files]
        IDX --> ANN[#2853 Verify Annexures]
        IDX --> XR[#2879 Test Cross-Ref]
        IDX --> REF[#2900 Referenced By]
    end
    
    %% Integration Layer - Timeline
    subgraph timeline[Timeline Chain - Week 3-6]
        TL[#2857 Update Timeline<br/>15 events]
        TL --> VIS[#2858 Visual Timeline]
        TL --> DATE[#2863 Date Verification<br/>✅ GATE]
        TL --> ANA[#2893 Timeline Analysis]
    end
    
    %% Integration Layer - Date Validation
    subgraph dates[Date Validation Chain - Week 5-6]
        VAL[#2869 Validate Dates]
        VAL --> CB[#2870 Cross-Border Analysis]
        VAL --> TV[#2875 Timeline Viz]
        VAL --> DMG[#2876 Damage Calc]
    end
    
    %% Integration Layer - Civil Evidence
    subgraph civil[Civil Evidence Chain - Week 5-6]
        CIV[#2789 Civil Evidence Suite<br/>⚠️ Enables 8 tasks]
        CIV --> PREP[#2790 Preponderance Pipeline]
        CIV --> MON[#2791 Monitoring]
        CIV --> BAL1[#2792 Balance Framework]
        CIV --> BAL2[#2794 Balance Tests]
        CIV --> HEAR[#2795 Hearsay]
        CIV --> EXP[#2796 Expert Testimony]
        CIV --> WIT2[#2797 Witness Credibility]
        CIV --> DUP[#2798 Duplicate Prevention]
    end
    
    %% Validation Layer
    subgraph validation[Validation Layer - Week 9-10]
        GATE1[#2863 Date Gate ✅]
        GATE2[#2864 Annexure Gate ✅]
        GATE3[#2903 Contradiction Gate ✅]
        GATE4[#2891/2897 Legal Review Gate ✅]
    end
    
    %% Dependencies
    foundation --> evidence
    foundation --> timeline
    foundation --> dates
    foundation --> civil
    
    evidence --> validation
    timeline --> validation
    dates --> validation
    civil --> validation
    
    %% Styling
    classDef bottleneck fill:#ff6b6b,stroke:#c92a2a,stroke-width:3px
    classDef gate fill:#51cf66,stroke:#2b8a3e,stroke-width:3px
    classDef critical fill:#ffd43b,stroke:#fab005,stroke-width:2px
    
    class RP,CIV bottleneck
    class DATE,GATE1,GATE2,GATE3,GATE4 gate
    class IDX,TL,VAL critical
```

## Dependency Statistics

- **Foundation Tasks:** 9
- **Integration Chains:** 4 (total 28 tasks)
- **Validation Gates:** 4
- **Critical Bottlenecks:** 2 (RP, CIV)
- **Total Tracked Tasks:** 150+

## Critical Path Analysis

### Longest Chain: Civil Evidence Suite
```
#2789 → [8 dependent tasks] → 6-week cascade risk
Timeline: Week 5-6
Mitigation: Modular design, daily standup
```

### Biggest Bottleneck: Responsible Person Documentation
```
#2834 → 37 jurisdictions → 4-6 weeks
Timeline: Week 1-2 START
Mitigation: Parallelize by jurisdiction
```

### Quality Gates (No Bypass)
```
Week 9-10:
  ✅ #2863 - Date Accuracy
  ✅ #2864 - Annexure Numbering
  ✅ #2903 - Contradiction Check
  ✅ #2891/2897 - Legal Review Prep
```
