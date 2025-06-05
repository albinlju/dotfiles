import http from 'http'

/**
 * A simple HTTP proxy that listens on a specified IP address and port,
 * and forwards all requests to a target port on localhost (typically your devcontainer).
 *
 * Usage:
 * node proxy.js [listen_address] [listen_port] [devcontainer_port]
 */

const args = process.argv.slice(2);

const LISTEN_ADDRESS = args[0] || process.env.LISTEN_ADDRESS || '0.0.0.0';
const LISTEN_PORT = parseInt(args[1] || process.env.LISTEN_PORT || '80', 10);
const DEVCONTAINER_TARGET_PORT = parseInt(args[2] || process.env.DEVCONTAINER_PORT || '3000', 10);

if (isNaN(LISTEN_PORT) || isNaN(DEVCONTAINER_TARGET_PORT)) {
  console.error('Error: Invalid port numbers provided. Ports must be integers.');
  process.exit(1);
}

// --- Proxy Server Creation ---
const proxy = http.createServer((req, res) => {
  const options = {
    hostname: 'localhost', // The devcontainer's forwarded port is always accessible via localhost on your host
    port: DEVCONTAINER_TARGET_PORT,
    path: req.url,
    method: req.method,
    headers: req.headers,
  };

  // Create a request to the target (devcontainer)
  const proxyReq = http.request(options, (proxyRes) => {
    // Forward the target's response back to the client
    res.writeHead(proxyRes.statusCode, proxyRes.headers);
    proxyRes.pipe(res, { end: true });
  });

  // Pipe the client's request body to the target
  req.pipe(proxyReq, { end: true });

  // Handle errors when proxying the request to the devcontainer
  proxyReq.on('error', (err) => {
    console.error(`[Proxy Error]: Request to devcontainer failed: ${err.message}`);
    if (!res.headersSent) {
      res.writeHead(502, { 'Content-Type': 'text/plain' }); // 502 Bad Gateway
      res.end(`Could not connect to devcontainer: ${err.message}. Ensure devcontainer is running and port ${DEVCONTAINER_TARGET_PORT} is forwarded.`);
    }
  });
});

// --- Server Startup ---
proxy.listen(LISTEN_PORT, LISTEN_ADDRESS, () => {
  console.log(`--- Simple HTTP Proxy Started ---`);
  console.log(`Listening on:   http://${LISTEN_ADDRESS}:${LISTEN_PORT}`);
  console.log(`Forwarding to:  http://localhost:${DEVCONTAINER_TARGET_PORT} (your devcontainer)`);
  console.log(`Access this proxy via: http://${LISTEN_ADDRESS === '0.0.0.0' ? 'your_computer_ip' : LISTEN_ADDRESS}:${LISTEN_PORT}`);
  console.log(`(e.g., http://192.168.1.10:${LISTEN_PORT} from another device on your network)`);
  console.log(`Press Ctrl+C to stop the proxy.`);
});

// --- Error Handling for Proxy Server Itself ---
proxy.on('error', (err) => {
  if (err.code === 'EADDRINUSE') {
    console.error(`Error: Address ${LISTEN_ADDRESS}:${LISTEN_PORT} is already in use.`);
    console.error('Please choose a different LISTEN_PORT or stop the conflicting process.');
  } else if (err.code === 'EACCES' && LISTEN_PORT <= 1023) {
    console.error(`Error: Permission denied to listen on port ${LISTEN_PORT}.`);
    console.error('Try a port number greater than 1023 (e.g., 8080) or run with `sudo`.');
  } else {
    console.error('An unexpected proxy server error occurred:', err.message);
  }
  process.exit(1); // Exit the process on critical errors
});

// --- Graceful Shutdown ---
process.on('SIGINT', () => {
  console.log('\n--- Stopping Simple HTTP Proxy ---');
  proxy.close(() => {
    console.log('Proxy gracefully stopped.');
    process.exit(0);
  });
});
