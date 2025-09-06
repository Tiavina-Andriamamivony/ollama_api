# Ollama Railway Deployment

A production-ready deployment configuration for running Ollama with Gemma2:2b model on Railway platform.

## Overview

This repository contains the necessary configuration files to deploy Ollama as a containerized service on Railway, providing a scalable API endpoint for language model inference.

## Architecture

- **Base Image**: `ollama/ollama:latest`
- **Model**: Gemma2:2b (2 billion parameters)
- **Platform**: Railway
- **Port**: 8080 (Railway managed)
- **API**: REST endpoints for text generation and chat completions

## Prerequisites

- Railway account
- GitHub repository
- Docker knowledge (optional)

## Project Structure

```
.
├── Dockerfile          # Container configuration
├── start.sh           # Service initialization script
├── railway.json       # Railway deployment settings
└── README.md         # Documentation
```

## Deployment

### Automatic Deployment

1. Fork or clone this repository
2. Connect your GitHub account to Railway
3. Create new project from GitHub repository
4. Railway automatically detects and builds the Dockerfile
5. Wait for initial deployment (5-10 minutes for model download)

### Manual Deployment via CLI

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login to Railway
railway login

# Initialize project
railway init

# Deploy
railway up
```

## Environment Variables

The following environment variables are configured automatically:

| Variable | Value | Description |
|----------|-------|-------------|
| `OLLAMA_HOST` | `0.0.0.0` | Bind address for external access |
| `MODEL` | `gemma2:2b` | Default language model |
| `PORT` | `8080` | Railway managed port |

## API Endpoints

### Health Check
```http
GET /api/tags
```

### Text Generation
```http
POST /api/generate
Content-Type: application/json

{
  "model": "gemma2:2b",
  "prompt": "Your prompt here",
  "stream": false
}
```

### Chat Completions
```http
POST /api/chat
Content-Type: application/json

{
  "model": "gemma2:2b",
  "messages": [
    {
      "role": "user",
      "content": "Your message here"
    }
  ],
  "stream": false
}
```

## Testing

### Using cURL

```bash
# Health check
curl https://your-app.railway.app/api/tags

# Text generation
curl -X POST https://your-app.railway.app/api/generate \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemma2:2b",
    "prompt": "What is artificial intelligence?",
    "stream": false
  }'
```

### Using Postman

1. Import the API endpoints listed above
2. Set base URL to your Railway deployment URL
3. Configure headers and request bodies as specified
4. Test endpoints sequentially starting with health check

## Resource Requirements

| Component | Requirement | Description |
|-----------|-------------|-------------|
| Memory | 2GB minimum, 4GB recommended | Model loading and inference |
| CPU | 1-2 vCPU | Text processing |
| Storage | 5GB | Model persistence |
| Bandwidth | Variable | API requests and responses |

## Performance Considerations

### Cold Start
- Initial deployment requires model download (5-10 minutes)
- First request after idle period may have higher latency
- Subsequent requests are processed normally

### Scaling
- Railway automatically handles traffic scaling
- Model remains loaded in memory for faster inference
- Single instance deployment (stateful model loading)

## Cost Estimation

Railway pricing is usage-based:
- **Hobby Plan**: ~$5/month for light usage
- **Pro Plan**: ~$20/month for moderate usage
- Actual costs depend on request volume and compute time

## Troubleshooting

### Common Issues

**Service Not Responding**
- Check Railway logs for startup errors
- Verify environment variables are set correctly
- Ensure adequate memory allocation

**Model Loading Failures**
- Confirm internet connectivity during deployment
- Check available storage space
- Review model compatibility

**API Timeouts**
- Increase request timeout settings
- Monitor resource usage in Railway dashboard
- Consider upgrading to higher-tier plan

### Monitoring

Monitor your deployment through Railway dashboard:
- CPU and memory usage
- Request logs and error rates
- Deployment status and health checks

## Security

### Best Practices
- Railway provides HTTPS endpoints by default
- Environment variables are securely managed
- No sensitive data stored in container images
- Regular security updates via base image updates

### Access Control
- Railway URLs are publicly accessible by default
- Implement application-level authentication if needed
- Use Railway's environment-based access controls

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit changes with descriptive messages
4. Submit a pull request

## License

This project is licensed under the MIT License. See LICENSE file for details.

## Support

For deployment issues:
- Check Railway documentation
- Review container logs
- Open GitHub issue for configuration problems

For Ollama-specific questions:
- Consult Ollama documentation
- Visit Ollama community forums