# Networking

## TCP & Sockets

* **Handshake Latency:** How do the TCP three-way handshake and the TLS handshake add round trips before the first byte, and how do TCP Fast Open, TLS 1.3, and connection reuse reduce them?
* **CLOSE_WAIT Accumulation:** A service accumulates thousands of sockets in `CLOSE_WAIT`. What does that say about the application code, and how do you find the leak?
* **Connection Pools:** Why are HTTP client connection pools critical, and what goes wrong with pools that are too small (queueing) or too large (overloading the server, stale connections)?
* **Nagle's Algorithm & Delayed ACKs:** How do Nagle's algorithm and delayed ACKs interact to add ~40ms latency to small writes, and why do RPC frameworks set `TCP_NODELAY`?
* **Keep-Alives, Heartbeats & Idle Timeouts:** Why do NAT gateways, firewalls, and load balancers silently drop idle TCP connections? Contrast TCP keep-alives with application-level heartbeats for detecting dead peers, and explain how to align idle timeouts between client, load balancer, and server.
* **UDP:** When should a backend choose UDP over TCP (DNS, metrics, media, QUIC), and which reliability, ordering, and congestion control must the application then provide?
* **Lab — TIME_WAIT Port Exhaustion:**
  * *Setup:* A client service opening many short-lived connections to one downstream starts failing with `EADDRNOTAVAIL` (cannot assign requested address).
  * *Challenge:* Explain why the side that closes first holds `TIME_WAIT` for 2×MSL, how that exhausts ephemeral ports toward a single destination, and fix it with connection reuse, HTTP/2, a wider port range, or `tcp_tw_reuse`. Why is shortening `TIME_WAIT` dangerous?
* **Lab — Too Many Open Files:**
  * *Setup:* An API gateway container (or a message broker) logs `EMFILE: too many open files` and stops accepting connections.
  * *Challenge:* Find the leak (unclosed sockets or channels, connection-per-request clients, slow upstreams holding connections), then check and raise limits at the right level: process `ulimit -n`, systemd `LimitNOFILE`, container runtime defaults, and kernel `fs.file-max`.

## HTTP & RPC

* **HTTP/1.1 Connection Reuse:** Explain persistent connections, why pipelining failed, and how browsers worked around head-of-line blocking by opening multiple connections.
* **HTTP/2:** How do binary framing and stream multiplexing remove application-level head-of-line blocking over one TCP connection? Why does one lost packet still stall every stream (TCP head-of-line blocking)?
* **HTTP/3 & QUIC:** How does QUIC over UDP give independent streams, 0-RTT/1-RTT setup, and connection migration across network changes? Which operational challenges does it bring (UDP blocked by middleboxes, CPU cost)?
* **gRPC vs REST:** Compare gRPC (HTTP/2, Protobuf, streaming, generated clients, deadlines) with REST/JSON regarding performance, contracts, tooling, and browser support (gRPC-Web).
* **WebSockets vs SSE:** Contrast WebSockets (full-duplex) with Server-Sent Events (server-to-client over plain HTTP, automatic reconnect) for real-time features. How do they scale behind load balancers?
* **Idempotent HTTP Methods:** Which methods are safe, and which are idempotent by spec (`GET`, `HEAD`, `PUT`, `DELETE` vs `POST`, `PATCH`)? Why does it matter for proxies, retries, and clients?
* **Content Negotiation & Compression:** How do `Accept`, `Content-Type`, `Accept-Encoding`, and `Content-Encoding` drive negotiation? When are gzip, Brotli, or zstd worth the CPU, and what is the BREACH risk when compressing secrets?
* **Status Code Semantics:** Distinguish `401` vs `403`, `429` vs `503`, and `502` vs `504`. How should clients react to each (retry? honor `Retry-After`?)?

## DNS, Load Balancing & Edge

* **DNS Resolution & TTLs:** Walk through recursive DNS resolution. Why do clients keep connecting to an old IP after a record change (resolver caches, OS caches, JVM DNS caching, long-lived connection pools), and how do you plan a low-TTL migration?
* **DNS Round-Robin:** Why is DNS round-robin crude load balancing (no health awareness, caching, client behavior), and what do real load balancers add?
* **L4 vs L7 Load Balancing:** Contrast layer-4 (connection-level) with layer-7 (request-level) load balancers. Which do you need for path routing, cookie affinity, and per-request balancing of HTTP/2 or gRPC?
* **Client IP Propagation:** Why are `X-Forwarded-For`, `X-Forwarded-Proto`, and `Forwarded` needed behind proxies, how can they be spoofed, and when do you use the PROXY protocol instead?
* **Anycast:** How do CDNs and global edge networks use IP anycast to route users to the nearest point of presence, and how does that interact with TCP and failover?
* **CDN Caching:** How do `Cache-Control` (`max-age`, `s-maxage`, `stale-while-revalidate`), `ETag`, and `Vary` control edge caching? Why are cache-busting URLs better than invalidations for deploys?
* **Edge Compute:** When do edge workers (Cloudflare Workers, CloudFront Functions, Lambda@Edge) make sense for personalization, auth, or redirects, and what limits do they impose?

## Scenarios

* **Lab — Asymmetric Routing Through Stateful Firewalls:**
  * *Setup:* A stateful firewall between two datacenters drops TCP packets intermittently. Captures show traffic leaving via path A and returning via path B.
  * *Challenge:* Explain why a stateful firewall drops packets for connections it never saw start, and fix it with symmetric routing or firewall state synchronization.
* **Lab — Slowloris:**
  * *Setup:* A web server stops accepting connections while CPU sits near idle. Clients are sending HTTP headers one byte at a time.
  * *Challenge:* Explain how slow clients exhaust thread-per-connection servers, and mitigate it with header/read timeouts, per-IP connection limits, event-driven servers, or a buffering reverse proxy.
* **Lab — MTU Black Hole:**
  * *Setup:* Clients can ping a server and load small pages, but large uploads and gRPC streams hang forever. Traffic goes through a VPN/overlay tunnel.
  * *Challenge:* Diagnose a path MTU black hole caused by encapsulation overhead plus blocked ICMP "Fragmentation Needed" messages, and fix it with MSS clamping, a lower MTU, or allowing that ICMP traffic.

## Study Guide

* **Books:**
  * *TCP/IP Illustrated, Volume 1* (W. Richard Stevens; second edition revised by Kevin R. Fall): the chapters on TCP connection management, timeouts and data flow, for handshakes, `TIME_WAIT`, keep-alives, Nagle and MTU.
  * *UNIX Network Programming, Volume 1* (W. Richard Stevens, Bill Fenner & Andrew M. Rudoff): the chapters on TCP client/server behavior and socket options, for `CLOSE_WAIT`, `TCP_NODELAY` and what the kernel does when you close a socket.
  * *High Performance Browser Networking* (Ilya Grigorik, free online from O'Reilly): the parts on TCP, TLS, HTTP/1.1, HTTP/2, WebSocket and Server-Sent Events, for latency, connection reuse and head-of-line blocking.
  * *HTTP/2 in Action* (Barry Pollard): the chapters on streams and multiplexing and on QUIC and HTTP/3, for what each protocol version fixed.
* **Official docs:** RFC 9293 (TCP), RFC 9110 (HTTP Semantics: methods, status codes, content negotiation), RFC 9111 (HTTP Caching), RFC 9113 (HTTP/2), RFC 9000 (QUIC) and RFC 9114 (HTTP/3), RFC 6455 (WebSocket), RFC 7239 (Forwarded), RFC 5861 (`stale-while-revalidate`), the HAProxy PROXY protocol specification, the HTML Living Standard's section on server-sent events, the gRPC docs on deadlines and load balancing, and the Linux `tcp(7)` man page and `ip-sysctl` kernel docs.
* **Papers:** "Congestion Avoidance and Control" (Van Jacobson, 1988); "The QUIC Transport Protocol: Design and Internet-Scale Deployment" (Langley et al., 2017).
* **Related technologies:** `tcpdump`, Wireshark, `ss`, `dig`, `mtr` and `curl --http3` for diagnosis; Envoy, NGINX and HAProxy as proxies and load balancers; Cloudflare, Fastly and CloudFront for CDN and edge behavior.
* **Search for:** `TIME_WAIT tcp_tw_reuse`, `CLOSE_WAIT leak`, `Nagle delayed ACK 40ms`, `TCP head-of-line blocking HTTP/2`, `PMTUD black hole MSS clamping`, `X-Forwarded-For spoofing`, `slowloris`, `BREACH compression attack`, `JVM DNS cache TTL`.
* **Hands-on:** capture `curl` requests in Wireshark over HTTP/1.1, HTTP/2 and HTTP/3 and count the round trips before the first byte; then watch `ss -tan` while closing connections from each side to see which end lands in `TIME_WAIT` and which in `CLOSE_WAIT`.
