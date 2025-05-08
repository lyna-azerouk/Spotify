curl -X POST "https://accounts.spotify.com/api/token" \
     -H "Authorization: Basic YTlmMTg3N2IwZjA2NDNkZGE0YTExZmEzZjE3YzdjNDE6OGI3N2I1MDFkN2VhNDdhM2EwODMyZWM4MDA1MDYwZTQ=" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=client_credentials"