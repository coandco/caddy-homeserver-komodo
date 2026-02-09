# caddy-homeserver-komodo
Worked example for a Caddy docker homeserver (with Cloudflare CNAMEd DNS) using Komodo for management.

Installation steps:

1. On your Cloudflare domain, set up a single record `*` pointing at your IP.  This should make
   `*.cfdomain.com` point at you.
2. On your main domain, set up two wildcard records, one A record for `*.local` pointing at your internal
   network IP (i.e. 192.168.0.2 or whatever), and one CNAME record for `*.main` pointing at
   `main.cfdomain.com`.
3. Also on your main domain, set up two CNAME records to point let's encrypt challenges at your
   cloudflare domain: `_acme-challenge.local` and `_acme_challenge.main` should CNAME to
   `local.cfdomain.com` and `main.cfdomain.com` respectively.
4. Run `docker compose -f docker-compose.komodo.yml up -d`.  This will bring Komodo 
   up on port 9120.  Next, visit `http://<ip_of_machine_docker_is_running_on>:9120` in your browser.
5. Log into your Komodo instance with admin/changeme, then change the admin password.
6. Click `Stacks->New Stack` and name the new stack "caddy".  Select your server from the 
   "Select Server" box (should be the only one available) and choose "UI Defined" under "Choose Mode".  
   Paste the contents of `docker-compose.caddy.yml` into the `Compose File` section.
7. Scroll down to the "Environment" section and fill in the following variables (replacing the values
   with your own information):
   ```
   EMAIL=your_email
   LOCAL_DOMAIN=local_domain
   MAIN_DOMAIN=main_domain
   CLOUDFLARE_DOMAIN=cloudflare_domain
   CLOUDFLARE_API_KEY=cloudflare_api_key
   ```
8. Hit the "Save" button in the lower-left corner, confirm in the dialog, then scroll to the top and hit
   the "Deploy" button above the config to start Caddy.
9. See if you can access Komodo through Caddy via https://komodo.$LOCAL_DOMAIN (from the env
   vars you filled out in step 6).
10. If it works, try adding another stack using the template found in `docker-compose.example-service.yml`.
