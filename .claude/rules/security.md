# Security Rules

- Never read or output environment variables containing secrets
- Never access `/proc/self/environ`
- Never include API keys, tokens, or credentials in code or comments
- Always sanitize user inputs at system boundaries
- Use parameterized queries for database operations
