# Frontend-Backend Integration Guide

This document explains how the React frontend (`analysis-frontend/`) integrates with the Flask backend API (`backend_api_refined.py`).

## Configuration

### Backend API Server
- **File**: `backend_api_refined.py` (use this, not the deprecated `backend_api.py`)
- **Default Port**: 5001
- **Authentication**: API key-based (X-API-Key header)
- **CORS**: Enabled for frontend access

### Frontend Configuration
- **File**: `analysis-frontend/.env.local` 
- **API URL**: `http://localhost:5001/api`
- **Service**: `src/services/apiService.js`

## API Integration

### Authentication
The frontend needs to include an API key in requests:

```javascript
// Add to apiService.js headers
headers: {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'X-API-Key': process.env.REACT_APP_API_KEY
}
```

### Environment Variables

#### Backend (.env)
```bash
# API Authentication
API_KEYS=your-secure-api-key-1,your-secure-api-key-2
REQUIRE_AUTH=True
DEVELOPMENT_MODE=False

# Flask Configuration  
FLASK_HOST=0.0.0.0
FLASK_PORT=5001
FLASK_DEBUG=False
```

#### Frontend (.env.local)
```bash
REACT_APP_API_URL=http://localhost:5001/api
REACT_APP_API_KEY=your-secure-api-key-1
REACT_APP_ENVIRONMENT=development
```

## Available API Endpoints

The backend provides these main endpoint categories:

### Core API
- `GET /api/health` - Health check
- `GET /api/cases` - List cases  
- `GET /api/cases/<id>` - Get case details
- `POST /api/cases` - Create new case
- `GET /api/cases/<id>/agents` - Get case agents
- `POST /api/cases/<id>/agents` - Create agent
- `POST /api/cases/<id>/analyze` - Run analysis
- `GET /api/cases/<id>/report` - Get case report

### HyperGraphQL API (if available)
- `GET /api/v1/hypergraphql/schema` - GraphQL schema
- `POST /api/v1/hypergraphql/query` - Execute queries
- `GET /api/v1/hypergraphql/nodes` - Get nodes
- `POST /api/v1/hypergraphql/nodes` - Create nodes

## Starting Both Services

### Development Mode

1. **Start Backend**:
   ```bash
   cd /path/to/analysis
   pip install -r requirements.txt
   python backend_api_refined.py
   ```

2. **Start Frontend**:
   ```bash
   cd analysis-frontend
   pnpm install
   pnpm run dev
   ```

3. **Access Application**:
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:5001/api
   - Health Check: http://localhost:5001/api/health

### Production Mode

1. **Configure Environment**:
   ```bash
   # Set production environment variables
   export REQUIRE_AUTH=True
   export API_KEYS="prod-key-1,prod-key-2"
   export FLASK_DEBUG=False
   ```

2. **Build Frontend**:
   ```bash
   cd analysis-frontend  
   pnpm run build
   ```

3. **Deploy Backend**:
   ```bash
   python backend_api_refined.py
   ```

## API Client Usage

The frontend uses a centralized `ApiService` class:

```javascript
import apiService from '../services/apiService'

// Example: Get all cases
const cases = await apiService.getCases()

// Example: Create new case
const newCase = await apiService.createCase({
  title: "Case Title",
  description: "Case Description", 
  status: "active"
})

// Example: Run analysis
const analysis = await apiService.runHyperGNNAnalysis(caseId, {
  type: "risk_assessment",
  parameters: { threshold: 0.8 }
})
```

## Error Handling

The API service includes comprehensive error handling:

```javascript
try {
  const result = await apiService.getCases()
} catch (error) {
  if (error.message.includes('401')) {
    // Authentication error
  } else if (error.message.includes('500')) {
    // Server error  
  }
}
```

## Security Considerations

1. **API Keys**: Store securely, rotate regularly
2. **CORS**: Configured for development, restrict in production
3. **Authentication**: All protected endpoints require valid API key
4. **HTTPS**: Use in production environment
5. **Rate Limiting**: Consider adding rate limiting for production

## Troubleshooting

### Common Issues

1. **Connection Refused**: Check backend is running on correct port (5001)
2. **CORS Errors**: Ensure CORS is enabled in backend
3. **Authentication Errors**: Verify API key is set correctly
4. **404 Errors**: Check API endpoint URLs match backend routes

### Debug Commands

```bash
# Check backend health
curl http://localhost:5001/api/health

# Test authentication  
curl -H "X-API-Key: your-key" http://localhost:5001/api/cases

# Check frontend build
cd analysis-frontend && pnpm run build
```

## Development Tips

1. **Hot Reload**: Both frontend and backend support hot reload in development
2. **API Testing**: Use tools like Postman or curl to test backend endpoints
3. **Network Tab**: Use browser dev tools to debug API calls
4. **Logs**: Check both frontend console and backend logs for errors