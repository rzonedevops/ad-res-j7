# HyperGNN Framework Versions Guide

This document clarifies the different HyperGNN framework implementations and their intended usage.

## Current Framework Versions

### 1. `frameworks/hypergnn_core_refined.py` ⭐ **CURRENT**
- **Status**: Primary implementation
- **Lines**: 727
- **Purpose**: Production-ready refined framework
- **Used by**: `backend_api_refined.py`
- **Features**: Enhanced error handling, refined API, production ready

### 2. `frameworks/hypergnn_core.py` 
- **Status**: Legacy/Stable
- **Lines**: 681  
- **Purpose**: Original stable implementation
- **Used by**: Legacy scripts and demos
- **Features**: Original feature set, well-tested

### 3. `frameworks/hypergnn_core_enhanced.py`
- **Status**: Duplicate of legacy
- **Lines**: 681 (identical to hypergnn_core.py)
- **Purpose**: Appears to be a duplicate
- **Recommendation**: Consider removing

### 4. `src/api/hypergnn_core.py`
- **Status**: API-specific implementation
- **Purpose**: API layer integration
- **Used by**: Demos and integration examples
- **Features**: API-focused interface

### 5. `src/models/hypergnn_framework_improved.py`
- **Status**: Improved model implementation
- **Purpose**: Enhanced model with better configuration
- **Features**: Advanced configuration, component factory pattern

## Usage Guidelines

### For New Development
Use `frameworks/hypergnn_core_refined.py` - this is the current production implementation.

```python
from frameworks.hypergnn_core_refined import RefinedHyperGNNFramework
```

### For Legacy Code
Existing code using `frameworks/hypergnn_core.py` can continue to work but should be migrated.

```python
# Legacy (still supported)
from frameworks.hypergnn_core import HyperGNNFramework

# Recommended for new code
from frameworks.hypergnn_core_refined import RefinedHyperGNNFramework
```

### For API Integration
Use the API-specific implementation for frontend/backend integration.

```python
from src.api.hypergnn_core import HyperGNNFramework
```

## Migration Plan

### Phase 1: Immediate (Current)
- ✅ Document framework versions and usage
- ✅ Establish `hypergnn_core_refined.py` as primary
- ✅ Update backend to use refined framework

### Phase 2: Short Term
- [ ] Update documentation to reference refined framework
- [ ] Create migration guide for existing code
- [ ] Add deprecation warnings to legacy versions

### Phase 3: Long Term  
- [ ] Migrate all existing code to refined framework
- [ ] Remove duplicate `hypergnn_core_enhanced.py`
- [ ] Consolidate API and core implementations
- [ ] Archive legacy versions

## Framework Capabilities Comparison

| Feature | Core | Enhanced | Refined | API | Improved |
|---------|------|----------|---------|-----|----------|
| Basic Analysis | ✅ | ✅ | ✅ | ✅ | ✅ |
| Error Handling | Basic | Basic | Advanced | Basic | Advanced |
| Configuration | Simple | Simple | Advanced | API-focused | Factory Pattern |
| Production Ready | Partial | Partial | ✅ | Partial | ✅ |
| API Integration | Manual | Manual | Built-in | Native | Built-in |
| Testing Coverage | Good | Good | Excellent | Good | Excellent |

## Version History

- **v1.0**: `hypergnn_core.py` - Original implementation
- **v1.1**: `hypergnn_core_enhanced.py` - Enhanced version (duplicate)
- **v2.0**: `hypergnn_core_refined.py` - Refined for production
- **v2.1**: `hypergnn_framework_improved.py` - Improved architecture

## Recommendations

1. **New Projects**: Use `hypergnn_core_refined.py`
2. **Existing Projects**: Plan migration to refined version
3. **API Development**: Use `src/api/hypergnn_core.py` or refined version
4. **Legacy Support**: Keep `hypergnn_core.py` for backward compatibility
5. **Cleanup**: Remove `hypergnn_core_enhanced.py` (duplicate)

## Support and Migration

For questions about framework versions or migration:
1. Check this documentation
2. Review the technical architecture documentation
3. Examine existing code examples in `examples/` directory
4. Refer to test cases for usage patterns