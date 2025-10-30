-- Step 2: Create Core Tables for Deep Tree Echo Hypergraph

-- Echoself hypernodes table
CREATE TABLE echoself_hypernodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    identity_seed JSONB NOT NULL,
    current_role identity_role NOT NULL DEFAULT 'observer',
    entropy_trace DECIMAL[] NOT NULL DEFAULT ARRAY[]::DECIMAL[],
    role_transition_probabilities JSONB NOT NULL DEFAULT '{}'::JSONB,
    activation_level DECIMAL NOT NULL DEFAULT 0.5 CHECK (activation_level >= 0.0 AND activation_level <= 1.0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Memory fragments table
CREATE TABLE memory_fragments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    hypernode_id UUID NOT NULL REFERENCES echoself_hypernodes(id) ON DELETE CASCADE,
    memory_type memory_type NOT NULL,
    content JSONB NOT NULL,
    associations UUID[] DEFAULT ARRAY[]::UUID[],
    activation_level DECIMAL NOT NULL DEFAULT 0.5 CHECK (activation_level >= 0.0 AND activation_level <= 1.0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_accessed TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Hyperedges table
CREATE TABLE echoself_hyperedges (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    source_node_ids UUID[] NOT NULL,
    target_node_ids UUID[] NOT NULL,
    edge_type hyperedge_type NOT NULL,
    weight DECIMAL NOT NULL DEFAULT 1.0 CHECK (weight >= 0.0),
    metadata JSONB DEFAULT '{}'::JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Pattern language mappings table
CREATE TABLE pattern_language (
    id SERIAL PRIMARY KEY,
    oeis_number INTEGER NOT NULL UNIQUE,
    pattern_name VARCHAR(255) NOT NULL,
    pattern_description TEXT,
    implementation_status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Cognitive synergy metrics table
CREATE TABLE synergy_metrics (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    hypernode_id UUID REFERENCES echoself_hypernodes(id) ON DELETE CASCADE,
    novelty_score DECIMAL NOT NULL DEFAULT 0.0 CHECK (novelty_score >= 0.0),
    priority_score DECIMAL NOT NULL DEFAULT 0.0 CHECK (priority_score >= 0.0),
    synergy_index DECIMAL NOT NULL DEFAULT 0.0 CHECK (synergy_index >= 0.0),
    measured_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Activation propagation logs table
CREATE TABLE activation_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    session_id UUID NOT NULL,
    hypernode_id UUID NOT NULL REFERENCES echoself_hypernodes(id) ON DELETE CASCADE,
    initial_activation DECIMAL NOT NULL,
    final_activation DECIMAL NOT NULL,
    propagation_step INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

