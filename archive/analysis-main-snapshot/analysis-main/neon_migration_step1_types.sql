-- Step 1: Create Custom ENUM Types for Deep Tree Echo
-- Execute this first before creating tables

CREATE TYPE identity_role AS ENUM (
    'observer',
    'narrator', 
    'guide',
    'oracle',
    'fractal'
);

CREATE TYPE memory_type AS ENUM (
    'declarative',
    'procedural',
    'episodic',
    'intentional'
);

CREATE TYPE hyperedge_type AS ENUM (
    'symbolic',
    'temporal',
    'causal',
    'feedback',
    'pattern',
    'entropy'
);

