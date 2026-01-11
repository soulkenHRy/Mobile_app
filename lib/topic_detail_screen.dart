import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

// Animated icon widget for each term
class AnimatedTermIcon extends StatefulWidget {
  final String termTitle;
  final Color color;

  const AnimatedTermIcon({
    super.key,
    required this.termTitle,
    required this.color,
  });

  @override
  State<AnimatedTermIcon> createState() => _AnimatedTermIconState();
}

class _AnimatedTermIconState extends State<AnimatedTermIcon>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _pulseAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _pulseController]),
      builder: (context, child) {
        return _buildIconForTerm();
      },
    );
  }

  Widget _buildIconForTerm() {
    final termLower = widget.termTitle.toLowerCase();

    // Performance & Optimization icons
    if (termLower.contains('latency')) {
      return _buildLatencyIcon();
    } else if (termLower.contains('throughput')) {
      return _buildThroughputIcon();
    } else if (termLower.contains('memory') ||
        termLower.contains('ram') ||
        termLower.contains('ssd')) {
      return _buildMemoryIcon();
    } else if (termLower.contains('caching') && !termLower.contains('hit')) {
      return _buildCachingIcon();
    } else if (termLower.contains('cache hit')) {
      return _buildCacheHitIcon();
    } else if (termLower.contains('in-memory')) {
      return _buildInMemoryCacheIcon();
    }
    // Scalability icons
    else if (termLower.contains('horizontal scaling')) {
      return _buildHorizontalScalingIcon();
    } else if (termLower.contains('vertical scaling')) {
      return _buildVerticalScalingIcon();
    } else if (termLower.contains('load balancing') &&
        !termLower.contains('round') &&
        !termLower.contains('client') &&
        !termLower.contains('health')) {
      return _buildLoadBalancingIcon();
    } else if (termLower.contains('round-robin')) {
      return _buildRoundRobinIcon();
    } else if (termLower.contains('client-ip')) {
      return _buildClientIPIcon();
    } else if (termLower.contains('server-health')) {
      return _buildServerHealthIcon();
    } else if (termLower.contains('sharding')) {
      return _buildShardingIcon();
    } else if (termLower.contains('data distribution')) {
      return _buildDataDistributionIcon();
    } else if (termLower.contains('hot spot')) {
      return _buildHotSpotIcon();
    } else if (termLower.contains('consistent hashing')) {
      return _buildConsistentHashingIcon();
    }
    // Database icons
    else if (termLower.contains('sql database')) {
      return _buildSQLIcon();
    } else if (termLower.contains('nosql')) {
      return _buildNoSQLIcon();
    } else if (termLower.contains('graph database')) {
      return _buildGraphDatabaseIcon();
    } else if (termLower.contains('time series')) {
      return _buildTimeSeriesIcon();
    } else if (termLower.contains('key-value')) {
      return _buildKeyValueIcon();
    } else if (termLower.contains('blob')) {
      return _buildBlobStoreIcon();
    } else if (termLower.contains('object storage')) {
      return _buildObjectStorageIcon();
    } else if (termLower.contains('hdfs')) {
      return _buildHDFSIcon();
    }
    // Consistency icons
    else if (termLower.contains('acid')) {
      return _buildACIDIcon();
    } else if (termLower.contains('base model')) {
      return _buildBASEIcon();
    } else if (termLower.contains('eventually consistent')) {
      return _buildEventuallyConsistentIcon();
    } else if (termLower.contains('stale data')) {
      return _buildStaleDataIcon();
    } else if (termLower.contains('consensus')) {
      return _buildConsensusIcon();
    } else if (termLower.contains('paxos')) {
      return _buildPaxosIcon();
    } else if (termLower.contains('raft')) {
      return _buildRaftIcon();
    } else if (termLower.contains('leader election')) {
      return _buildLeaderElectionIcon();
    } else if (termLower.contains('idempotency')) {
      return _buildIdempotencyIcon();
    }
    // Messaging & Communication icons
    else if (termLower.contains('pub/sub') ||
        termLower.contains('publisher/subscriber')) {
      return _buildPubSubIcon();
    } else if (termLower.contains('message delivery')) {
      return _buildMessageDeliveryIcon();
    } else if (termLower.contains('at-least-once')) {
      return _buildAtLeastOnceIcon();
    } else if (termLower.contains('message ordering')) {
      return _buildMessageOrderingIcon();
    } else if (termLower.contains('replayability')) {
      return _buildReplayabilityIcon();
    } else if (termLower.contains('streaming')) {
      return _buildStreamingIcon();
    }
    // Network & Security icons
    else if (termLower.contains('http')) {
      return _buildHTTPIcon();
    } else if (termLower.contains('tcp')) {
      return _buildTCPIcon();
    } else if (termLower.contains('ip') && !termLower.contains('client')) {
      return _buildIPIcon();
    } else if (termLower.contains('protocol stack')) {
      return _buildProtocolStackIcon();
    } else if (termLower.contains('symmetric encryption')) {
      return _buildSymmetricEncryptionIcon();
    } else if (termLower.contains('asymmetric encryption')) {
      return _buildAsymmetricEncryptionIcon();
    } else if (termLower.contains('public/private key')) {
      return _buildPublicPrivateKeyIcon();
    } else if (termLower.contains('tls handshake')) {
      return _buildTLSHandshakeIcon();
    } else if (termLower.contains('man-in-the-middle')) {
      return _buildMITMIcon();
    } else if (termLower.contains('proxy') || termLower.contains('proxies')) {
      return _buildProxyIcon();
    }
    // Reliability & Monitoring icons
    else if (termLower.contains('high availability')) {
      return _buildHighAvailabilityIcon();
    } else if (termLower.contains('fault tolerance')) {
      return _buildFaultToleranceIcon();
    } else if (termLower.contains('redundancy')) {
      return _buildRedundancyIcon();
    } else if (termLower.contains('sla')) {
      return _buildSLAIcon();
    } else if (termLower.contains('slo')) {
      return _buildSLOIcon();
    } else if (termLower.contains('rate limiting')) {
      return _buildRateLimitingIcon();
    } else if (termLower.contains('dos') || termLower.contains('ddos')) {
      return _buildDDoSIcon();
    } else if (termLower.contains('circuit breaker')) {
      return _buildCircuitBreakerIcon();
    }
    // Real-World System Examples
    else if (termLower.contains('dropbox')) {
      return _buildDropboxIcon();
    } else if (termLower.contains('facebook')) {
      return _buildFacebookIcon();
    } else if (termLower.contains('whatsapp')) {
      return _buildWhatsAppIcon();
    } else if (termLower.contains('youtube')) {
      return _buildYouTubeIcon();
    } else if (termLower.contains('stock trading')) {
      return _buildStockTradingIcon();
    }
    // Technologies & Tools
    else if (termLower.contains('redis')) {
      return _buildRedisIcon();
    } else if (termLower.contains('kafka')) {
      return _buildKafkaIcon();
    } else if (termLower.contains('mysql') ||
        termLower.contains('postgresql')) {
      return _buildMySQLIcon();
    } else if (termLower.contains('nginx')) {
      return _buildNginxIcon();
    }
    // Default animated icon
    else {
      return _buildDefaultIcon();
    }
  }

  // Latency - Stopwatch animation
  Widget _buildLatencyIcon() {
    return Transform.scale(
      scale: _scaleAnimation.value,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.timer_outlined, color: widget.color, size: 28),
            // Animated clock hand
            Transform.rotate(
              angle: _controller.value * 2 * 3.14159,
              child: Container(
                width: 2,
                height: 10,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Throughput - Multiple arrows flowing
  Widget _buildThroughputIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Multiple arrows flowing through
          Transform.translate(
            offset: Offset(-10 + (_controller.value * 20), 0),
            child: Opacity(
              opacity: _pulseAnimation.value,
              child: Icon(Icons.double_arrow, color: widget.color, size: 20),
            ),
          ),
          Transform.translate(
            offset: Offset(-10 + ((_controller.value + 0.3) % 1.0 * 20), -8),
            child: Opacity(
              opacity: _pulseAnimation.value * 0.7,
              child: Icon(
                Icons.double_arrow,
                color: widget.color.withOpacity(0.7),
                size: 16,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(-10 + ((_controller.value + 0.6) % 1.0 * 20), 8),
            child: Opacity(
              opacity: _pulseAnimation.value * 0.7,
              child: Icon(
                Icons.double_arrow,
                color: widget.color.withOpacity(0.7),
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Memory/RAM/SSD - Stack of memory layers
  Widget _buildMemoryIcon() {
    return Transform.scale(
      scale: _scaleAnimation.value,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Layered memory representation
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 28,
                  height: 6,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(
                      _pulseAnimation.value,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  width: 28,
                  height: 6,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(
                      _pulseAnimation.value * 0.8,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  width: 28,
                  height: 6,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.withOpacity(
                      _pulseAnimation.value * 0.6,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Container(
                  width: 28,
                  height: 6,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent.withOpacity(
                      _pulseAnimation.value * 0.4,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Caching - Box with lightning bolt
  Widget _buildCachingIcon() {
    return Transform.rotate(
      angle: _rotationAnimation.value,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              color: widget.color.withOpacity(0.5),
              size: 28,
            ),
            Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(Icons.bolt, color: Colors.yellowAccent, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  // Cache Hit - Checkmark appearing
  Widget _buildCacheHitIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.folder_open,
            color: widget.color.withOpacity(0.6),
            size: 24,
          ),
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.translate(
              offset: const Offset(8, 8),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(
                        _pulseAnimation.value * 0.5,
                      ),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // In-Memory Cache - RAM chip with glow
  Widget _buildInMemoryCacheIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(_pulseAnimation.value * 0.4),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.memory,
            color: Colors.cyan.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // Horizontal Scaling - Multiple servers appearing
  Widget _buildHorizontalScalingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 0.8 + (_pulseAnimation.value * 0.2),
            child: Icon(Icons.dns, color: widget.color, size: 14),
          ),
          Transform.scale(
            scale: 0.8 + (_pulseAnimation.value * 0.2),
            child: Icon(Icons.dns, color: widget.color, size: 14),
          ),
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.add_circle, color: Colors.greenAccent, size: 14),
          ),
        ],
      ),
    );
  }

  // Vertical Scaling - Server growing taller
  Widget _buildVerticalScalingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scaleY: 0.8 + (_pulseAnimation.value * 0.4),
            child: Icon(Icons.dns, color: widget.color, size: 28),
          ),
          Positioned(
            top: 4,
            child: Transform.translate(
              offset: Offset(0, -4 * _pulseAnimation.value),
              child: Icon(
                Icons.keyboard_arrow_up,
                color: Colors.greenAccent,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Load Balancing - Distribution animation
  Widget _buildLoadBalancingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Central load balancer
          Icon(Icons.account_tree, color: widget.color, size: 24),
          // Animated dots flowing
          ...List.generate(3, (i) {
            final angle = (i * 120 + _controller.value * 360) * 3.14159 / 180;
            return Transform.translate(
              offset: Offset(cos(angle) * 14, sin(angle) * 14),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.yellowAccent.withOpacity(_pulseAnimation.value),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Round Robin - Circular rotation
  Widget _buildRoundRobinIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.rotate(
        angle: _controller.value * 2 * 3.14159,
        child: Stack(
          alignment: Alignment.center,
          children: [Icon(Icons.loop, color: widget.color, size: 28)],
        ),
      ),
    );
  }

  // Client IP - User with network
  Widget _buildClientIPIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.person_pin_circle, color: widget.color, size: 28),
          ),
          Positioned(
            bottom: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'IP',
                style: TextStyle(
                  color: Colors.greenAccent.withOpacity(_pulseAnimation.value),
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Server Health - Heartbeat
  Widget _buildServerHealthIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: 0.9 + (_pulseAnimation.value * 0.2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.monitor_heart,
              color: Colors.redAccent.withOpacity(_pulseAnimation.value),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  // Sharding - Splitting database
  Widget _buildShardingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Multiple shards spreading
          Transform.translate(
            offset: Offset(
              -8 * _pulseAnimation.value,
              -4 * _pulseAnimation.value,
            ),
            child: Icon(Icons.storage, color: widget.color, size: 14),
          ),
          Transform.translate(
            offset: Offset(
              8 * _pulseAnimation.value,
              -4 * _pulseAnimation.value,
            ),
            child: Icon(Icons.storage, color: widget.color, size: 14),
          ),
          Transform.translate(
            offset: Offset(0, 8 * _pulseAnimation.value),
            child: Icon(Icons.storage, color: widget.color, size: 14),
          ),
        ],
      ),
    );
  }

  // Data Distribution - Network of nodes
  Widget _buildDataDistributionIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.hub,
            color: widget.color.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
          ...List.generate(4, (i) {
            final angle = (i * 90 + 45) * 3.14159 / 180;
            return Transform.translate(
              offset: Offset(cos(angle) * 12, sin(angle) * 12),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(_pulseAnimation.value),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Hot Spots - Fire icon
  Widget _buildHotSpotIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(_pulseAnimation.value * 0.4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(
          Icons.local_fire_department,
          color: Colors.orange,
          size: 28,
        ),
      ),
    );
  }

  // Consistent Hashing - Ring with nodes
  Widget _buildConsistentHashingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.rotate(
        angle: _controller.value * 0.5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: widget.color, width: 2),
              ),
            ),
            ...List.generate(4, (i) {
              final angle = (i * 90) * 3.14159 / 180;
              return Transform.translate(
                offset: Offset(cos(angle) * 15, sin(angle) * 15),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color:
                        i == ((_controller.value * 4).floor() % 4)
                            ? Colors.greenAccent
                            : widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // SQL Database - Table grid
  Widget _buildSQLIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.table_chart, color: widget.color, size: 28),
      ),
    );
  }

  // NoSQL - Flexible document
  Widget _buildNoSQLIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.rotate(
        angle: _rotationAnimation.value,
        child: Icon(Icons.description, color: widget.color, size: 28),
      ),
    );
  }

  // Graph Database - Connected nodes
  Widget _buildGraphDatabaseIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.scatter_plot,
            color: widget.color.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // Time Series - Chart with time
  Widget _buildTimeSeriesIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.show_chart, color: widget.color, size: 24),
          Positioned(
            bottom: 6,
            right: 6,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(Icons.access_time, color: Colors.cyan, size: 14),
            ),
          ),
        ],
      ),
    );
  }

  // Key-Value Store
  Widget _buildKeyValueIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.vpn_key, color: Colors.amber, size: 18),
            Icon(Icons.arrow_forward, color: widget.color, size: 12),
            Icon(Icons.data_object, color: Colors.cyan, size: 18),
          ],
        ),
      ),
    );
  }

  // Blob Store - Large file
  Widget _buildBlobStoreIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.cloud_queue, color: widget.color, size: 28),
            Transform.translate(
              offset: Offset(0, _pulseAnimation.value * 2),
              child: Icon(Icons.image, color: Colors.purpleAccent, size: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Object Storage
  Widget _buildObjectStorageIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: _rotationAnimation.value,
            child: Icon(
              Icons.widgets,
              color: widget.color.withOpacity(_pulseAnimation.value),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  // HDFS
  Widget _buildHDFSIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.folder_copy, color: Colors.amber, size: 28),
          ),
        ],
      ),
    );
  }

  // ACID Properties
  Widget _buildACIDIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.shield, color: Colors.greenAccent, size: 28),
          ),
          const Positioned(
            child: Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BASE Model
  Widget _buildBASEIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.sync, color: Colors.orangeAccent, size: 28),
          ),
        ],
      ),
    );
  }

  // Eventually Consistent - Syncing arrows
  Widget _buildEventuallyConsistentIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: _controller.value * 3.14159,
            child: Icon(
              Icons.sync,
              color: Colors.blueAccent.withOpacity(_pulseAnimation.value),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  // Stale Data - Old clock
  Widget _buildStaleDataIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.history,
            color: Colors.grey.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Icon(Icons.warning_amber, color: Colors.amber, size: 14),
          ),
        ],
      ),
    );
  }

  // Consensus - Voting/Agreement
  Widget _buildConsensusIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.how_to_vote, color: widget.color, size: 28),
          ),
        ],
      ),
    );
  }

  // Paxos - Complex voting
  Widget _buildPaxosIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.rotate(
            angle: _rotationAnimation.value,
            child: Icon(
              Icons.hub,
              color: Colors.purpleAccent.withOpacity(_pulseAnimation.value),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  // Raft - Simple consensus
  Widget _buildRaftIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.sailing, color: Colors.blueAccent, size: 28),
          ),
        ],
      ),
    );
  }

  // Leader Election - Crown
  Widget _buildLeaderElectionIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(_pulseAnimation.value * 0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.star, color: Colors.amber, size: 28),
      ),
    );
  }

  // Idempotency - Equal sign
  Widget _buildIdempotencyIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.repeat_one,
                color: widget.color.withOpacity(_pulseAnimation.value),
                size: 20,
              ),
              Text(
                '=',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.repeat,
                color: widget.color.withOpacity(_pulseAnimation.value),
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Pub/Sub - Publishing pattern
  Widget _buildPubSubIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.rss_feed, color: widget.color, size: 24),
          ...List.generate(3, (i) {
            return Transform.translate(
              offset: Offset(8 + (_pulseAnimation.value * 4), -8 + (i * 8)),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(_pulseAnimation.value),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Message Delivery - Envelope
  Widget _buildMessageDeliveryIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.translate(
        offset: Offset(_pulseAnimation.value * 4 - 2, 0),
        child: Icon(Icons.mail, color: widget.color, size: 28),
      ),
    );
  }

  // At-least-once - Multiple envelopes
  Widget _buildAtLeastOnceIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(-6, -4),
            child: Icon(
              Icons.mail,
              color: widget.color.withOpacity(0.5),
              size: 20,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 0),
            child: Icon(
              Icons.mail,
              color: widget.color.withOpacity(0.7),
              size: 22,
            ),
          ),
          Transform.translate(
            offset: Offset(6, 4),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(Icons.mail, color: widget.color, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  // Message Ordering - Numbered queue
  Widget _buildMessageOrderingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.format_list_numbered,
            color: widget.color.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // Replayability - Rewind
  Widget _buildReplayabilityIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.rotate(
        angle: -_controller.value * 2 * 3.14159,
        child: Icon(Icons.replay, color: Colors.cyan, size: 28),
      ),
    );
  }

  // Streaming - Flow
  Widget _buildStreamingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.stream,
            color: widget.color.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // HTTP - Globe with arrow
  Widget _buildHTTPIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.language, color: Colors.blueAccent, size: 28),
      ),
    );
  }

  // TCP - Reliable connection
  Widget _buildTCPIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.compare_arrows,
            color: widget.color.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
          Positioned(
            bottom: 4,
            child: Icon(
              Icons.check_circle,
              color: Colors.greenAccent,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }

  // IP - Address
  Widget _buildIPIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.router, color: widget.color, size: 28),
      ),
    );
  }

  // Protocol Stack - Layers
  Widget _buildProtocolStackIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 6,
            margin: EdgeInsets.symmetric(vertical: 1),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(_pulseAnimation.value),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: 28,
            height: 6,
            margin: EdgeInsets.symmetric(vertical: 1),
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(
                _pulseAnimation.value * 0.8,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            width: 28,
            height: 6,
            margin: EdgeInsets.symmetric(vertical: 1),
            decoration: BoxDecoration(
              color: Colors.orangeAccent.withOpacity(
                _pulseAnimation.value * 0.6,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  // Symmetric Encryption - Single key
  Widget _buildSymmetricEncryptionIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.rotate(
        angle: _rotationAnimation.value,
        child: Icon(Icons.key, color: Colors.amber, size: 28),
      ),
    );
  }

  // Asymmetric Encryption - Two keys
  Widget _buildAsymmetricEncryptionIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(-8, 0),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(Icons.key, color: Colors.greenAccent, size: 20),
            ),
          ),
          Transform.translate(
            offset: Offset(8, 0),
            child: Transform.rotate(
              angle: 3.14159,
              child: Icon(Icons.key, color: Colors.redAccent, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // Public/Private Key
  Widget _buildPublicPrivateKeyIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.lock_open,
            color: Colors.greenAccent.withOpacity(_pulseAnimation.value),
            size: 18,
          ),
          Transform.translate(
            offset: Offset(10, 8),
            child: Icon(Icons.lock, color: Colors.redAccent, size: 18),
          ),
        ],
      ),
    );
  }

  // TLS Handshake
  Widget _buildTLSHandshakeIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(_pulseAnimation.value * 0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.handshake, color: Colors.greenAccent, size: 28),
      ),
    );
  }

  // Man-in-the-middle - Warning spy
  Widget _buildMITMIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.person_off, color: Colors.redAccent, size: 24),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Icon(
              Icons.warning,
              color: Colors.amber.withOpacity(_pulseAnimation.value),
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  // Proxy - Intermediary
  Widget _buildProxyIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(Icons.swap_horiz, color: widget.color, size: 28),
          ),
        ],
      ),
    );
  }

  // High Availability - Always on
  Widget _buildHighAvailabilityIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withOpacity(_pulseAnimation.value * 0.4),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.cloud_done,
            color: Colors.greenAccent.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // Fault Tolerance - Shield
  Widget _buildFaultToleranceIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(
          Icons.health_and_safety,
          color: Colors.blueAccent,
          size: 28,
        ),
      ),
    );
  }

  // Redundancy - Multiple copies
  Widget _buildRedundancyIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: Offset(-6, -4),
            child: Icon(
              Icons.storage,
              color: widget.color.withOpacity(0.5),
              size: 18,
            ),
          ),
          Transform.translate(
            offset: Offset(0, 0),
            child: Icon(
              Icons.storage,
              color: widget.color.withOpacity(0.7),
              size: 20,
            ),
          ),
          Transform.translate(
            offset: Offset(6, 4),
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(Icons.storage, color: widget.color, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  // SLA - Contract
  Widget _buildSLAIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.description, color: Colors.blueAccent, size: 28),
      ),
    );
  }

  // SLO - Target
  Widget _buildSLOIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.gps_fixed, color: Colors.greenAccent, size: 28),
      ),
    );
  }

  // Rate Limiting - Speedometer
  Widget _buildRateLimitingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.speed, color: widget.color, size: 24),
          Positioned(
            bottom: 4,
            right: 4,
            child: Icon(
              Icons.do_not_disturb,
              color: Colors.redAccent.withOpacity(_pulseAnimation.value),
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  // DDoS - Attack waves
  Widget _buildDDoSIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.dns, color: widget.color, size: 20),
          ...List.generate(3, (i) {
            return Transform.translate(
              offset: Offset(-12 + (_controller.value * 24), -8 + (i * 8)),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.redAccent.withOpacity(_pulseAnimation.value),
                size: 12,
              ),
            );
          }),
        ],
      ),
    );
  }

  // Circuit Breaker - Switch
  Widget _buildCircuitBreakerIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.power_off, color: Colors.orangeAccent, size: 28),
      ),
    );
  }

  // Dropbox - Cloud storage
  Widget _buildDropboxIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.cloud_upload, color: Colors.blueAccent, size: 28),
      ),
    );
  }

  // Facebook - Social network
  Widget _buildFacebookIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.feed,
            color: Colors.blue.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // WhatsApp - Messaging
  Widget _buildWhatsAppIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.chat_bubble, color: Colors.greenAccent, size: 28),
      ),
    );
  }

  // YouTube - Video streaming
  Widget _buildYouTubeIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.play_circle_fill,
            color: Colors.redAccent.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // Stock Trading - Chart
  Widget _buildStockTradingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.candlestick_chart,
            color: Colors.greenAccent.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // Redis - Fast cache
  Widget _buildRedisIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(_pulseAnimation.value * 0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.bolt, color: Colors.redAccent, size: 28),
      ),
    );
  }

  // Kafka - Message stream
  Widget _buildKafkaIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.filter_alt,
            color: widget.color.withOpacity(_pulseAnimation.value),
            size: 28,
          ),
        ],
      ),
    );
  }

  // MySQL/PostgreSQL - Database
  Widget _buildMySQLIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.table_rows, color: Colors.blueAccent, size: 28),
      ),
    );
  }

  // Nginx - Load balancer
  Widget _buildNginxIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.rotate(
        angle: _rotationAnimation.value,
        child: Icon(Icons.settings, color: Colors.greenAccent, size: 28),
      ),
    );
  }

  // Default animated icon
  Widget _buildDefaultIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Icon(Icons.auto_awesome, color: widget.color, size: 24),
      ),
    );
  }
}

// Animated Diagram Widget - Shows visual diagrams for each concept
class AnimatedConceptDiagram extends StatefulWidget {
  final String termTitle;
  final Color color;

  const AnimatedConceptDiagram({
    super.key,
    required this.termTitle,
    required this.color,
  });

  @override
  State<AnimatedConceptDiagram> createState() => _AnimatedConceptDiagramState();
}

class _AnimatedConceptDiagramState extends State<AnimatedConceptDiagram>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _secondaryController;
  late AnimationController _dataFlowController;
  late Animation<double> _progressAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _flowAnimation;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _secondaryController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _dataFlowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _mainController, curve: Curves.linear));

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _secondaryController, curve: Curves.easeInOut),
    );

    _flowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _dataFlowController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _mainController.dispose();
    _secondaryController.dispose();
    _dataFlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _mainController,
        _secondaryController,
        _dataFlowController,
      ]),
      builder: (context, child) {
        return _buildDiagramForTerm() ?? const SizedBox.shrink();
      },
    );
  }

  Widget? _buildDiagramForTerm() {
    final termLower = widget.termTitle.toLowerCase();

    // Performance & Optimization diagrams
    if (termLower.contains('latency')) {
      return _buildLatencyDiagram();
    } else if (termLower.contains('throughput')) {
      return _buildThroughputDiagram();
    } else if (termLower.contains('memory') ||
        termLower.contains('ram') ||
        termLower.contains('ssd')) {
      return _buildMemoryHierarchyDiagram();
    } else if (termLower.contains('caching') &&
        !termLower.contains('hit') &&
        !termLower.contains('in-memory')) {
      return _buildCachingDiagram();
    } else if (termLower.contains('cache hit')) {
      return _buildCacheHitDiagram();
    } else if (termLower.contains('in-memory')) {
      return _buildInMemoryCacheDiagram();
    }
    // Scalability diagrams
    else if (termLower.contains('horizontal scaling')) {
      return _buildHorizontalScalingDiagram();
    } else if (termLower.contains('vertical scaling')) {
      return _buildVerticalScalingDiagram();
    } else if (termLower.contains('load balancing') &&
        !termLower.contains('round') &&
        !termLower.contains('client') &&
        !termLower.contains('health')) {
      return _buildLoadBalancingDiagram();
    } else if (termLower.contains('round-robin')) {
      return _buildRoundRobinDiagram();
    } else if (termLower.contains('client-ip')) {
      return _buildClientIPDiagram();
    } else if (termLower.contains('server-health')) {
      return _buildServerHealthDiagram();
    } else if (termLower.contains('sharding')) {
      return _buildShardingDiagram();
    } else if (termLower.contains('data distribution')) {
      return _buildDataDistributionDiagram();
    } else if (termLower.contains('hot spot')) {
      return _buildHotSpotDiagram();
    } else if (termLower.contains('consistent hashing')) {
      return _buildConsistentHashingDiagram();
    }
    // Database diagrams
    else if (termLower.contains('sql database')) {
      return _buildSQLDiagram();
    } else if (termLower.contains('nosql')) {
      return _buildNoSQLDiagram();
    } else if (termLower.contains('graph database')) {
      return _buildGraphDatabaseDiagram();
    } else if (termLower.contains('time series')) {
      return _buildTimeSeriesDiagram();
    } else if (termLower.contains('key-value')) {
      return _buildKeyValueDiagram();
    } else if (termLower.contains('blob store')) {
      return _buildBlobStoreDiagram();
    } else if (termLower.contains('object storage')) {
      return _buildObjectStorageDiagram();
    } else if (termLower.contains('hdfs')) {
      return _buildHDFSDiagram();
    }
    // Data Consistency diagrams
    else if (termLower.contains('acid')) {
      return _buildACIDDiagram();
    } else if (termLower.contains('base model')) {
      return _buildBASEDiagram();
    } else if (termLower.contains('eventually consistent')) {
      return _buildEventuallyConsistentDiagram();
    } else if (termLower.contains('stale data')) {
      return _buildStaleDataDiagram();
    } else if (termLower.contains('consensus')) {
      return _buildConsensusDiagram();
    } else if (termLower.contains('paxos')) {
      return _buildPaxosDiagram();
    } else if (termLower.contains('raft')) {
      return _buildRaftDiagram();
    } else if (termLower.contains('leader election')) {
      return _buildLeaderElectionDiagram();
    } else if (termLower.contains('idempotency')) {
      return _buildIdempotencyDiagram();
    }
    // Messaging diagrams
    else if (termLower.contains('pub/sub')) {
      return _buildPubSubDiagram();
    } else if (termLower.contains('publisher/subscriber')) {
      return _buildPublisherSubscriberDiagram();
    } else if (termLower.contains('message delivery')) {
      return _buildMessageDeliveryDiagram();
    } else if (termLower.contains('at-least-once')) {
      return _buildAtLeastOnceDiagram();
    } else if (termLower.contains('message ordering')) {
      return _buildMessageOrderingDiagram();
    } else if (termLower.contains('replayability')) {
      return _buildReplayabilityDiagram();
    } else if (termLower.contains('streaming vs')) {
      return _buildStreamingVsRequestDiagram();
    }
    // Network diagrams
    else if (termLower.contains('http') && !termLower.contains('https')) {
      return _buildHTTPDiagram();
    } else if (termLower.contains('tcp')) {
      return _buildTCPDiagram();
    } else if (termLower.contains('ip (internet protocol)') ||
        (termLower.contains('ip') && termLower.contains('internet'))) {
      return _buildIPDiagram();
    } else if (termLower.contains('protocol stack')) {
      return _buildProtocolStackDiagram();
    } else if (termLower.contains('symmetric encryption')) {
      return _buildSymmetricEncryptionDiagram();
    } else if (termLower.contains('asymmetric encryption')) {
      return _buildAsymmetricEncryptionDiagram();
    } else if (termLower.contains('public/private key')) {
      return _buildPublicPrivateKeyDiagram();
    } else if (termLower.contains('tls handshake')) {
      return _buildTLSHandshakeDiagram();
    } else if (termLower.contains('man-in-the-middle')) {
      return _buildMITMDiagram();
    } else if (termLower == 'proxies') {
      return _buildProxyDiagram();
    } else if (termLower.contains('forward proxy')) {
      return _buildForwardProxyDiagram();
    } else if (termLower.contains('reverse proxy')) {
      return _buildReverseProxyDiagram();
    }
    // Reliability diagrams
    else if (termLower.contains('high availability')) {
      return _buildHighAvailabilityDiagram();
    } else if (termLower.contains('fault tolerance')) {
      return _buildFaultToleranceDiagram();
    } else if (termLower.contains('redundancy')) {
      return _buildRedundancyDiagram();
    } else if (termLower.contains('sla')) {
      return _buildSLADiagram();
    } else if (termLower.contains('slo')) {
      return _buildSLODiagram();
    } else if (termLower.contains('circuit breaker')) {
      return _buildCircuitBreakerDiagram();
    } else if (termLower.contains('rate limiting')) {
      return _buildRateLimitingDiagram();
    } else if (termLower.contains('dos') || termLower.contains('ddos')) {
      return _buildDDoSDiagram();
    }
    // Real-World Examples
    else if (termLower.contains('dropbox')) {
      return _buildDropboxDiagram();
    } else if (termLower.contains('facebook')) {
      return _buildFacebookDiagram();
    } else if (termLower.contains('whatsapp')) {
      return _buildWhatsAppDiagram();
    } else if (termLower.contains('youtube')) {
      return _buildYouTubeDiagram();
    } else if (termLower.contains('stock trading')) {
      return _buildStockTradingDiagram();
    }
    // Technologies & Tools
    else if (termLower.contains('redis')) {
      return _buildRedisDiagram();
    } else if (termLower.contains('etcd')) {
      return _buildEtcdDiagram();
    } else if (termLower.contains('kafka')) {
      return _buildKafkaDiagram();
    } else if (termLower.contains('zookeeper')) {
      return _buildZooKeeperDiagram();
    } else if (termLower.contains('mysql')) {
      return _buildMySQLDiagram();
    } else if (termLower.contains('postgresql')) {
      return _buildPostgreSQLDiagram();
    } else if (termLower.contains('neo4j')) {
      return _buildNeo4jDiagram();
    } else if (termLower.contains('prometheus')) {
      return _buildPrometheusDiagram();
    } else if (termLower.contains('amazon s3') || termLower == 's3') {
      return _buildS3Diagram();
    } else if (termLower.contains('google cloud storage') ||
        termLower.contains('gcs')) {
      return _buildGCSDiagram();
    } else if (termLower.contains('hadoop') && !termLower.contains('hdfs')) {
      return _buildHadoopDiagram();
    } else if (termLower.contains('nginx')) {
      return _buildNginxDiagram();
    }
    // Advanced Concepts
    else if (termLower.contains('mapreduce')) {
      return _buildMapReduceDiagram();
    } else if (termLower.contains('batch processing')) {
      return _buildBatchProcessingDiagram();
    } else if (termLower.contains('asynchronous')) {
      return _buildAsyncProcessingDiagram();
    } else if (termLower.contains('peer-to-peer')) {
      return _buildP2PDiagram();
    } else if (termLower.contains('cdn') ||
        termLower.contains('content delivery')) {
      return _buildCDNDiagram();
    } else if (termLower.contains('points of presence') ||
        termLower.contains('pop')) {
      return _buildPoPDiagram();
    } else if (termLower.contains('edge computing')) {
      return _buildEdgeComputingDiagram();
    } else if (termLower.contains('configuration management')) {
      return _buildConfigManagementDiagram();
    } else if (termLower.contains('yaml')) {
      return _buildYAMLDiagram();
    } else if (termLower.contains('json')) {
      return _buildJSONDiagram();
    } else if (termLower.contains('feature flag')) {
      return _buildFeatureFlagsDiagram();
    }
    // API Design
    else if (termLower.contains('restful')) {
      return _buildRESTfulDiagram();
    } else if (termLower.contains('crud')) {
      return _buildCRUDDiagram();
    } else if (termLower.contains('pagination')) {
      return _buildPaginationDiagram();
    } else if (termLower.contains('authentication')) {
      return _buildAuthenticationDiagram();
    } else if (termLower.contains('authorization')) {
      return _buildAuthorizationDiagram();
    }
    // Architecture Patterns
    else if (termLower.contains('microservices')) {
      return _buildMicroservicesDiagram();
    } else if (termLower.contains('monolith')) {
      return _buildMonolithDiagram();
    } else if (termLower.contains('event-driven')) {
      return _buildEventDrivenDiagram();
    } else if (termLower.contains('service mesh')) {
      return _buildServiceMeshDiagram();
    } else if (termLower.contains('auto-scaling')) {
      return _buildAutoScalingDiagram();
    } else if (termLower.contains('geographic distribution') ||
        termLower.contains('multi-region')) {
      return _buildGeoDistributionDiagram();
    } else if (termLower.contains('data locality')) {
      return _buildDataLocalityDiagram();
    }

    return null; // No diagram for this term
  }

  // Container wrapper for all diagrams
  Widget _diagramContainer({required Widget child, required String title}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: widget.color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schema, color: widget.color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: widget.color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  // LATENCY DIAGRAM - Request/Response timeline
  Widget _buildLatencyDiagram() {
    return _diagramContainer(
      title: 'How Latency Works',
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            // Client box
            Positioned(
              left: 0,
              top: 40,
              child: _buildBox('Client', Colors.blue, 60, 40),
            ),
            // Server box
            Positioned(
              right: 0,
              top: 40,
              child: _buildBox('Server', Colors.green, 60, 40),
            ),
            // Request arrow (animated)
            Positioned(
              left: 65,
              top: 45,
              child: _buildAnimatedArrow(
                width: 180,
                color: Colors.orange,
                label: 'Request',
                progress:
                    _flowAnimation.value < 0.5 ? _flowAnimation.value * 2 : 1.0,
                showLabel: _flowAnimation.value < 0.5,
              ),
            ),
            // Response arrow (animated, appears after request)
            Positioned(
              left: 65,
              top: 75,
              child: Opacity(
                opacity: _flowAnimation.value > 0.5 ? 1.0 : 0.0,
                child: _buildAnimatedArrow(
                  width: 180,
                  color: Colors.cyan,
                  label: 'Response',
                  progress:
                      _flowAnimation.value > 0.5
                          ? (_flowAnimation.value - 0.5) * 2
                          : 0.0,
                  reverse: true,
                  showLabel: _flowAnimation.value > 0.5,
                ),
              ),
            ),
            // Latency indicator
            Positioned(
              left: 100,
              top: 0,
              child: Column(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.amber.withOpacity(_pulseAnimation.value),
                    size: 20,
                  ),
                  Text(
                    'Latency = Total Time',
                    style: TextStyle(
                      color: Colors.amber.withOpacity(_pulseAnimation.value),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // THROUGHPUT DIAGRAM - Multiple requests flowing
  Widget _buildThroughputDiagram() {
    return _diagramContainer(
      title: 'Throughput Visualization',
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            // Pipeline
            Positioned(
              left: 60,
              top: 50,
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Center(
                  child: Text(
                    'System Pipeline',
                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                  ),
                ),
              ),
            ),
            // Multiple requests flowing through
            ...List.generate(5, (i) {
              final offset = ((_flowAnimation.value + i * 0.2) % 1.0);
              return Positioned(
                left: 60 + (offset * 200),
                top: 55 + (i % 3 - 1) * 10.0,
                child: Opacity(
                  opacity: offset < 0.9 ? 1.0 : (1.0 - offset) * 10,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color:
                          [
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.purple,
                            Colors.red,
                          ][i],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: [
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.purple,
                            Colors.red,
                          ][i].withOpacity(0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            // Labels
            const Positioned(
              left: 0,
              top: 60,
              child: Text(
                'IN',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Positioned(
              right: 0,
              top: 60,
              child: Text(
                'OUT',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Counter
            Positioned(
              left: 120,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  'Throughput: ${(5 * _pulseAnimation.value).toInt()} req/sec',
                  style: const TextStyle(color: Colors.green, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MEMORY HIERARCHY DIAGRAM
  Widget _buildMemoryHierarchyDiagram() {
    return _diagramContainer(
      title: 'Memory Speed Hierarchy',
      child: SizedBox(
        height: 160,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMemoryTier('RAM', '~100ns', Colors.green, 0.3, 0),
            const Icon(Icons.chevron_right, color: Colors.grey),
            _buildMemoryTier('SSD', '~100µs', Colors.blue, 0.5, 1),
            const Icon(Icons.chevron_right, color: Colors.grey),
            _buildMemoryTier('Network', '~100ms', Colors.orange, 0.7, 2),
            const Icon(Icons.chevron_right, color: Colors.grey),
            _buildMemoryTier('Global', '~500ms', Colors.red, 0.9, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryTier(
    String label,
    String speed,
    Color color,
    double height,
    int index,
  ) {
    final isActive = (_progressAnimation.value * 4).floor() == index;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          speed,
          style: TextStyle(
            color: color.withOpacity(_pulseAnimation.value),
            fontSize: 9,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 50,
          height: 40 + (height * 60),
          decoration: BoxDecoration(
            color: isActive ? color : color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isActive ? Colors.white : color,
              width: isActive ? 2 : 1,
            ),
            boxShadow:
                isActive
                    ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10)]
                    : [],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // CACHING DIAGRAM
  Widget _buildCachingDiagram() {
    final phase = (_flowAnimation.value * 3).floor();
    return _diagramContainer(
      title: 'How Caching Works',
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            // Client
            Positioned(
              left: 0,
              top: 55,
              child: _buildBox('Client', Colors.blue, 50, 35),
            ),
            // Cache
            Positioned(
              left: 90,
              top: 40,
              child: Container(
                width: 70,
                height: 65,
                decoration: BoxDecoration(
                  color:
                      phase >= 1
                          ? Colors.amber.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: phase >= 1 ? Colors.amber : Colors.grey,
                    width: phase >= 1 ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bolt,
                      color: phase >= 1 ? Colors.amber : Colors.grey,
                      size: 20,
                    ),
                    Text(
                      'Cache',
                      style: TextStyle(
                        color: phase >= 1 ? Colors.amber : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    if (phase >= 2)
                      Text(
                        '✓ Hit!',
                        style: TextStyle(color: Colors.green, fontSize: 9),
                      ),
                  ],
                ),
              ),
            ),
            // Database
            Positioned(
              right: 0,
              top: 55,
              child: _buildBox('Database', Colors.purple, 55, 35),
            ),
            // Arrows
            if (phase >= 0)
              Positioned(
                left: 52,
                top: 65,
                child: _buildSimpleArrow(
                  35,
                  Colors.blue.withOpacity(
                    phase == 0 ? _pulseAnimation.value : 0.3,
                  ),
                ),
              ),
            if (phase >= 1 && phase < 2)
              Positioned(
                left: 162,
                top: 65,
                child: _buildSimpleArrow(
                  40,
                  Colors.orange.withOpacity(_pulseAnimation.value),
                ),
              ),
            if (phase >= 2)
              Positioned(
                left: 52,
                top: 80,
                child: _buildSimpleArrow(35, Colors.green, reverse: true),
              ),
            // Phase indicator
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildPhaseIndicator('1. Request', phase >= 0),
                  const SizedBox(width: 8),
                  _buildPhaseIndicator('2. Check Cache', phase >= 1),
                  const SizedBox(width: 8),
                  _buildPhaseIndicator('3. Return Fast!', phase >= 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: active ? Colors.green.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active ? Colors.green : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.green : Colors.grey,
          fontSize: 9,
        ),
      ),
    );
  }

  // CACHE HIT DIAGRAM
  Widget _buildCacheHitDiagram() {
    return _diagramContainer(
      title: 'Cache Hit vs Cache Miss',
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            // Cache Hit side
            Expanded(
              child: Column(
                children: [
                  const Text(
                    '✓ CACHE HIT',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                      ),
                      Icon(
                        Icons.bolt,
                        color: Colors.green.withOpacity(_pulseAnimation.value),
                        size: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '~1ms',
                    style: TextStyle(
                      color: Colors.green.withOpacity(_pulseAnimation.value),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 80,
              color: Colors.grey.withOpacity(0.3),
            ),
            // Cache Miss side
            Expanded(
              child: Column(
                children: [
                  const Text(
                    '✗ CACHE MISS',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 2),
                        ),
                      ),
                      const Icon(
                        Icons.hourglass_empty,
                        color: Colors.red,
                        size: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '~100ms',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // IN-MEMORY CACHE DIAGRAM
  Widget _buildInMemoryCacheDiagram() {
    return _diagramContainer(
      title: 'In-Memory Cache (RAM)',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // RAM chip visualization
            Container(
              width: 100,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.cyan, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.memory,
                    color: Colors.cyan.withOpacity(_pulseAnimation.value),
                    size: 30,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'RAM',
                    style: TextStyle(color: Colors.cyan, fontSize: 12),
                  ),
                  Text(
                    'Super Fast!',
                    style: TextStyle(
                      color: Colors.cyan.withOpacity(_pulseAnimation.value),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            // Data flowing
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final offset = (_flowAnimation.value + i * 0.33) % 1.0;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Transform.translate(
                    offset: Offset(offset * 40 - 20, 0),
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(1 - offset),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }),
            ),
            // Warning
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning_amber, color: Colors.amber, size: 20),
                  SizedBox(height: 4),
                  Text(
                    'Data lost',
                    style: TextStyle(color: Colors.amber, fontSize: 9),
                  ),
                  Text(
                    'on restart',
                    style: TextStyle(color: Colors.amber, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HORIZONTAL SCALING DIAGRAM
  Widget _buildHorizontalScalingDiagram() {
    final serverCount = ((_progressAnimation.value * 3).floor() + 1).clamp(
      1,
      4,
    );
    return _diagramContainer(
      title: 'Horizontal Scaling - Add More Servers',
      child: SizedBox(
        height: 120,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (i) {
                final isVisible = i < serverCount;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isVisible ? 1.0 : 0.2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color:
                                isVisible
                                    ? Colors.blue.withOpacity(0.3)
                                    : Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  isVisible
                                      ? Colors.blue
                                      : Colors.grey.withOpacity(0.3),
                              width: isVisible ? 2 : 1,
                            ),
                          ),
                          child: Icon(
                            Icons.dns,
                            color: isVisible ? Colors.blue : Colors.grey,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Server ${i + 1}',
                          style: TextStyle(
                            color: isVisible ? Colors.white : Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green),
              ),
              child: Text(
                'Capacity: ${serverCount}x',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // VERTICAL SCALING DIAGRAM
  Widget _buildVerticalScalingDiagram() {
    return _diagramContainer(
      title: 'Vertical Scaling - Make Server Bigger',
      child: SizedBox(
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Before
            Column(
              children: [
                const Text(
                  'Before',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.dns, color: Colors.blue, size: 24),
                      Text(
                        '2 CPU',
                        style: TextStyle(color: Colors.blue, fontSize: 8),
                      ),
                      Text(
                        '4GB RAM',
                        style: TextStyle(color: Colors.blue, fontSize: 8),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Arrow
            Icon(
              Icons.arrow_forward,
              color: Colors.amber.withOpacity(_pulseAnimation.value),
              size: 30,
            ),
            // After
            Column(
              children: [
                const Text(
                  'After',
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
                const SizedBox(height: 8),
                Transform.scale(
                  scale: 0.8 + (_pulseAnimation.value * 0.2),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.dns, color: Colors.green, size: 28),
                        Text(
                          '16 CPU',
                          style: TextStyle(color: Colors.green, fontSize: 9),
                        ),
                        Text(
                          '64GB RAM',
                          style: TextStyle(color: Colors.green, fontSize: 9),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // LOAD BALANCING DIAGRAM
  Widget _buildLoadBalancingDiagram() {
    return _diagramContainer(
      title: 'Load Balancer Distribution',
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            // Users
            Positioned(
              left: 0,
              top: 50,
              child: Column(
                children: [
                  Icon(
                    Icons.people,
                    color: Colors.blue.withOpacity(_pulseAnimation.value),
                    size: 30,
                  ),
                  const Text(
                    'Users',
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                  ),
                ],
              ),
            ),
            // Load Balancer
            Positioned(
              left: 100,
              top: 40,
              child: Container(
                width: 70,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: _progressAnimation.value * 2 * 3.14159,
                      child: const Icon(
                        Icons.shuffle,
                        color: Colors.amber,
                        size: 24,
                      ),
                    ),
                    const Text(
                      'LB',
                      style: TextStyle(color: Colors.amber, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            // Servers
            ...List.generate(3, (i) {
              final isActive = (_progressAnimation.value * 3).floor() == i;
              return Positioned(
                right: 0,
                top: 10.0 + (i * 45),
                child: Row(
                  children: [
                    // Animated connection line
                    if (isActive)
                      Container(
                        width: 50,
                        height: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.amber.withOpacity(0), Colors.green],
                          ),
                        ),
                      ),
                    Container(
                      width: 60,
                      height: 35,
                      decoration: BoxDecoration(
                        color:
                            isActive
                                ? Colors.green.withOpacity(0.3)
                                : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isActive ? Colors.green : Colors.grey,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.dns,
                            color: isActive ? Colors.green : Colors.grey,
                            size: 16,
                          ),
                          Text(
                            'S${i + 1}',
                            style: TextStyle(
                              color: isActive ? Colors.green : Colors.grey,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // SHARDING DIAGRAM
  Widget _buildShardingDiagram() {
    return _diagramContainer(
      title: 'Database Sharding',
      child: SizedBox(
        height: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Original database
            Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.storage, color: Colors.purple, size: 24),
                  Text(
                    'Big DB',
                    style: TextStyle(color: Colors.purple, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Arrow
            Icon(
              Icons.arrow_forward,
              color: Colors.amber.withOpacity(_pulseAnimation.value),
              size: 24,
            ),
            const SizedBox(width: 16),
            // Shards
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                final isAnimating = (_progressAnimation.value * 3).floor() == i;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Transform.scale(
                    scale: isAnimating ? 1.1 : 1.0,
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                        color: [
                          Colors.blue,
                          Colors.green,
                          Colors.orange,
                        ][i].withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: [Colors.blue, Colors.green, Colors.orange][i],
                          width: isAnimating ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.storage,
                            color:
                                [Colors.blue, Colors.green, Colors.orange][i],
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            ['A-H', 'I-Q', 'R-Z'][i],
                            style: TextStyle(
                              color:
                                  [Colors.blue, Colors.green, Colors.orange][i],
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // CONSISTENT HASHING DIAGRAM
  Widget _buildConsistentHashingDiagram() {
    return _diagramContainer(
      title: 'Consistent Hashing Ring',
      child: SizedBox(
        height: 150,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // The ring
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                ),
              ),
              // Nodes on the ring
              ...List.generate(4, (i) {
                final angle =
                    (i * 90 + _progressAnimation.value * 30) * 3.14159 / 180;
                final isActive = (_progressAnimation.value * 4).floor() == i;
                return Transform.translate(
                  offset: Offset(cos(angle) * 60, sin(angle) * 60),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color:
                          isActive
                              ? Colors.green
                              : Colors.blue.withOpacity(0.5),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive ? Colors.white : Colors.blue,
                        width: 2,
                      ),
                      boxShadow:
                          isActive
                              ? [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5),
                                  blurRadius: 8,
                                ),
                              ]
                              : [],
                    ),
                    child: Center(
                      child: Text(
                        'S${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              // Data point moving
              Transform.translate(
                offset: Offset(
                  cos(_progressAnimation.value * 2 * 3.14159) * 45,
                  sin(_progressAnimation.value * 2 * 3.14159) * 45,
                ),
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // SQL DIAGRAM
  Widget _buildSQLDiagram() {
    return _diagramContainer(
      title: 'SQL Table Structure',
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Table header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                ),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Text(
                      'ID',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Age',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Rows
            ...List.generate(3, (i) {
              final isHighlighted = (_progressAnimation.value * 3).floor() == i;
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color:
                      isHighlighted
                          ? Colors.amber.withOpacity(0.2)
                          : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: isHighlighted ? Colors.amber : Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        ['Alice', 'Bob', 'Charlie'][i],
                        style: TextStyle(
                          color: isHighlighted ? Colors.amber : Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ['25', '30', '28'][i],
                        style: TextStyle(
                          color: isHighlighted ? Colors.amber : Colors.white70,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // NoSQL DIAGRAM
  Widget _buildNoSQLDiagram() {
    return _diagramContainer(
      title: 'NoSQL Document Structure',
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('{', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildJsonLine(
                    '"name":',
                    '"Alice"',
                    Colors.cyan,
                    Colors.orange,
                  ),
                  _buildJsonLine('"age":', '25', Colors.cyan, Colors.purple),
                  _buildJsonLine(
                    '"hobbies":',
                    '["reading", "coding"]',
                    Colors.cyan,
                    Colors.green,
                  ),
                  _buildJsonLine(
                    '"address":',
                    '{...}',
                    Colors.cyan,
                    Colors.amber,
                  ),
                ],
              ),
            ),
            Text('}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildJsonLine(
    String key,
    String value,
    Color keyColor,
    Color valueColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(key, style: TextStyle(color: keyColor, fontSize: 11)),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: valueColor.withOpacity(_pulseAnimation.value),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // KEY-VALUE DIAGRAM
  Widget _buildKeyValueDiagram() {
    return _diagramContainer(
      title: 'Key-Value Store',
      child: Column(
        children: List.generate(3, (i) {
          final isActive = (_progressAnimation.value * 3).floor() == i;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                // Key
                Container(
                  width: 80,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(isActive ? 0.3 : 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.amber.withOpacity(isActive ? 1 : 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.key, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        ['user:1', 'user:2', 'user:3'][i],
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                // Arrow
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.arrow_forward,
                    color: isActive ? Colors.white : Colors.grey,
                    size: 16,
                  ),
                ),
                // Value
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan.withOpacity(isActive ? 0.3 : 0.1),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Colors.cyan.withOpacity(isActive ? 1 : 0.3),
                      ),
                    ),
                    child: Text(
                      [
                        '{"name":"Alice"}',
                        '{"name":"Bob"}',
                        '{"name":"Charlie"}',
                      ][i],
                      style: TextStyle(
                        color: Colors.cyan.withOpacity(isActive ? 1 : 0.5),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // PUB/SUB DIAGRAM
  Widget _buildPubSubDiagram() {
    return _diagramContainer(
      title: 'Publisher/Subscriber Pattern',
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            // Publisher
            Positioned(
              left: 0,
              top: 50,
              child: _buildBox('Publisher', Colors.orange, 65, 40),
            ),
            // Topic/Channel
            Positioned(
              left: 110,
              top: 35,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.purple, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: _pulseAnimation.value,
                      child: const Icon(
                        Icons.rss_feed,
                        color: Colors.purple,
                        size: 24,
                      ),
                    ),
                    const Text(
                      'Topic',
                      style: TextStyle(color: Colors.purple, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            // Subscribers
            ...List.generate(3, (i) {
              return Positioned(
                right: 0,
                top: 10.0 + (i * 45),
                child: _buildBox('Sub ${i + 1}', Colors.green, 50, 30),
              );
            }),
            // Message flowing
            Positioned(
              left: 70 + (_flowAnimation.value * 35),
              top: 62,
              child: Opacity(
                opacity: _flowAnimation.value < 0.4 ? 1 : 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.amber.withOpacity(0.5),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Messages to subscribers
            ...List.generate(3, (i) {
              final startOffset = 0.4 + (i * 0.1);
              final progress =
                  (_flowAnimation.value - startOffset).clamp(0.0, 0.3) / 0.3;
              if (_flowAnimation.value > startOffset) {
                return Positioned(
                  left: 185 + (progress * 40),
                  top: 25.0 + (i * 45),
                  child: Opacity(
                    opacity: 1 - progress,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPublisherSubscriberDiagram() {
    return _diagramContainer(
      title: 'Publisher/Subscriber Pattern',
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.send,
                        color: Colors.blue.withOpacity(_pulseAnimation.value),
                      ),
                      const Text(
                        'Publisher',
                        style: TextStyle(color: Colors.blue, fontSize: 9),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(_flowAnimation.value * 30, 0),
                  child: const Icon(Icons.email, color: Colors.amber, size: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Events',
                  style: TextStyle(
                    color: Colors.amber.withOpacity(_pulseAnimation.value),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hub, color: Colors.purple),
                  Text(
                    'Event Bus',
                    style: TextStyle(color: Colors.purple, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.green.withOpacity(_pulseAnimation.value),
                        size: 14,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Icon(
                          Icons.inbox,
                          color: Colors.green,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TCP DIAGRAM
  Widget _buildTCPDiagram() {
    final phase = (_progressAnimation.value * 4).floor();
    return _diagramContainer(
      title: 'TCP 3-Way Handshake',
      child: SizedBox(
        height: 150,
        child: Stack(
          children: [
            // Client
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: _buildBox('Client', Colors.blue, 60, 130),
            ),
            // Server
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: _buildBox('Server', Colors.green, 60, 130),
            ),
            // SYN
            if (phase >= 0)
              Positioned(
                left: 70,
                top: 20,
                child: _buildHandshakeArrow('SYN', Colors.orange, phase == 0),
              ),
            // SYN-ACK
            if (phase >= 1)
              Positioned(
                left: 70,
                top: 60,
                child: _buildHandshakeArrow(
                  'SYN-ACK',
                  Colors.cyan,
                  phase == 1,
                  reverse: true,
                ),
              ),
            // ACK
            if (phase >= 2)
              Positioned(
                left: 70,
                top: 100,
                child: _buildHandshakeArrow('ACK', Colors.green, phase == 2),
              ),
            // Connected indicator
            if (phase >= 3)
              Positioned(
                left: 100,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    '✓ Connected!',
                    style: TextStyle(
                      color: Colors.green.withOpacity(_pulseAnimation.value),
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandshakeArrow(
    String label,
    Color color,
    bool isActive, {
    bool reverse = false,
  }) {
    return Row(
      children: [
        if (reverse) const SizedBox(width: 150),
        if (!reverse)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(isActive ? 0.3 : 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(label, style: TextStyle(color: color, fontSize: 10)),
          ),
        SizedBox(
          width: reverse ? 0 : 100,
          child: Icon(
            reverse ? Icons.arrow_back : Icons.arrow_forward,
            color: isActive ? color : color.withOpacity(0.3),
            size: 20,
          ),
        ),
        if (reverse)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(isActive ? 0.3 : 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(label, style: TextStyle(color: color, fontSize: 10)),
          ),
      ],
    );
  }

  // TLS HANDSHAKE DIAGRAM
  Widget _buildTLSHandshakeDiagram() {
    return _diagramContainer(
      title: 'TLS Handshake (Simplified)',
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Client
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android,
                  color: Colors.blue.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'Client',
                  style: TextStyle(color: Colors.blue, fontSize: 10),
                ),
              ],
            ),
            // Handshake steps
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTLSStep('1. Hello', _progressAnimation.value > 0.2),
                _buildTLSStep('2. Certificate', _progressAnimation.value > 0.4),
                _buildTLSStep(
                  '3. Key Exchange',
                  _progressAnimation.value > 0.6,
                ),
                _buildTLSStep('4. Encrypted!', _progressAnimation.value > 0.8),
              ],
            ),
            // Server
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.dns,
                  color: Colors.green.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'Server',
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTLSStep(String label, bool completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.green : Colors.grey,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: completed ? Colors.green : Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // CIRCUIT BREAKER DIAGRAM
  Widget _buildCircuitBreakerDiagram() {
    final state =
        (_progressAnimation.value * 3)
            .floor(); // 0: Closed, 1: Open, 2: Half-Open
    final stateColors = [Colors.green, Colors.red, Colors.amber];
    final stateLabels = ['CLOSED', 'OPEN', 'HALF-OPEN'];

    return _diagramContainer(
      title: 'Circuit Breaker States',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            final isActive = state == i;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color:
                        isActive
                            ? stateColors[i].withOpacity(0.3)
                            : Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          isActive
                              ? stateColors[i]
                              : Colors.grey.withOpacity(0.3),
                      width: isActive ? 3 : 1,
                    ),
                    boxShadow:
                        isActive
                            ? [
                              BoxShadow(
                                color: stateColors[i].withOpacity(0.5),
                                blurRadius: 10,
                              ),
                            ]
                            : [],
                  ),
                  child: Icon(
                    [Icons.check, Icons.close, Icons.hourglass_top][i],
                    color: isActive ? stateColors[i] : Colors.grey,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stateLabels[i],
                  style: TextStyle(
                    color: isActive ? stateColors[i] : Colors.grey,
                    fontSize: 10,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // RATE LIMITING DIAGRAM
  Widget _buildRateLimitingDiagram() {
    return _diagramContainer(
      title: 'Rate Limiting',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Request bucket
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Requests',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                const SizedBox(height: 4),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Container(
                      width: 56,
                      height: 56 * _pulseAnimation.value,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 20),
            // Gate
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.filter_alt,
                  color: Colors.amber.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'Limit: 100/sec',
                  style: TextStyle(color: Colors.amber, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(width: 20),
            // Output
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Allowed',
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
                const SizedBox(height: 4),
                ...List.generate(3, (i) {
                  final offset = (_flowAnimation.value + i * 0.33) % 1.0;
                  return Transform.translate(
                    offset: Offset(0, offset * 20 - 10),
                    child: Opacity(
                      opacity: 1 - offset,
                      child: Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Widget _buildBox(String label, Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildAnimatedArrow({
    required double width,
    required Color color,
    required String label,
    required double progress,
    bool reverse = false,
    bool showLabel = true,
  }) {
    return SizedBox(
      width: width,
      height: 25,
      child: Stack(
        children: [
          // Arrow line
          Positioned(
            left: reverse ? width * (1 - progress) : 0,
            top: 10,
            child: Container(width: width * progress, height: 2, color: color),
          ),
          // Arrow head
          if (progress > 0.1)
            Positioned(
              left: reverse ? width * (1 - progress) - 5 : width * progress - 5,
              top: 5,
              child: Icon(
                reverse ? Icons.arrow_left : Icons.arrow_right,
                color: color,
                size: 16,
              ),
            ),
          // Label
          if (showLabel)
            Positioned(
              left: width / 2 - 25,
              top: 0,
              child: Text(label, style: TextStyle(color: color, fontSize: 9)),
            ),
        ],
      ),
    );
  }

  Widget _buildSimpleArrow(double width, Color color, {bool reverse = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: width, height: 2, color: color),
        Icon(
          reverse ? Icons.arrow_left : Icons.arrow_right,
          color: color,
          size: 14,
        ),
      ],
    );
  }

  // ============ SCALABILITY DIAGRAMS ============

  Widget _buildRoundRobinDiagram() {
    final activeServer = (_progressAnimation.value * 4).floor() % 4;
    return _diagramContainer(
      title: 'Round-Robin: Taking Turns',
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (i) {
            final isActive = activeServer == i;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color:
                          isActive
                              ? Colors.green.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isActive ? Colors.green : Colors.grey,
                        width: isActive ? 3 : 1,
                      ),
                      boxShadow:
                          isActive
                              ? [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.5),
                                  blurRadius: 10,
                                ),
                              ]
                              : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dns,
                          color: isActive ? Colors.green : Colors.grey,
                          size: 20,
                        ),
                        Text(
                          '${i + 1}',
                          style: TextStyle(
                            color: isActive ? Colors.green : Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (isActive)
                    Icon(Icons.arrow_upward, color: Colors.amber, size: 20),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildClientIPDiagram() {
    return _diagramContainer(
      title: 'Client-IP Sticky Sessions',
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'User A',
                  style: TextStyle(color: Colors.blue, fontSize: 10),
                ),
                const Text(
                  'IP: 1.2.3.4',
                  style: TextStyle(color: Colors.blue, fontSize: 8),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: Colors.blue.withOpacity(_pulseAnimation.value),
                ),
                const SizedBox(height: 20),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.green.withOpacity(_pulseAnimation.value),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBox('Server 1', Colors.blue, 60, 35),
                const SizedBox(height: 10),
                _buildBox('Server 2', Colors.green, 60, 35),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServerHealthDiagram() {
    return _diagramContainer(
      title: 'Health-Based Load Balancing',
      child: SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildServerHealthBox('S1', 0.3, Colors.green),
            _buildServerHealthBox('S2', 0.9, Colors.red),
            _buildServerHealthBox('S3', 0.5, Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildServerHealthBox(String label, double load, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              width: 50,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Container(
              width: 46,
              height: 56 * load,
              decoration: BoxDecoration(
                color: color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 10)),
        Text(
          '${(load * 100).toInt()}%',
          style: TextStyle(color: color, fontSize: 9),
        ),
      ],
    );
  }

  Widget _buildDataDistributionDiagram() {
    return _diagramContainer(
      title: 'Data Distribution Across Nodes',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (i) {
            final isActive = (_flowAnimation.value * 4).floor() == i;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color:
                      isActive
                          ? Colors.blue.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isActive ? Colors.blue : Colors.grey,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.storage,
                      color: isActive ? Colors.blue : Colors.grey,
                      size: 20,
                    ),
                    Text(
                      'Node ${i + 1}',
                      style: TextStyle(
                        color: isActive ? Colors.blue : Colors.grey,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHotSpotDiagram() {
    return _diagramContainer(
      title: 'Hot Spot Problem',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildServerWithTraffic('S1', 0.2, false),
            _buildServerWithTraffic('S2', 0.95, true),
            _buildServerWithTraffic('S3', 0.15, false),
          ],
        ),
      ),
    );
  }

  Widget _buildServerWithTraffic(String label, double traffic, bool isHot) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isHot)
            Icon(
              Icons.local_fire_department,
              color: Colors.orange.withOpacity(_pulseAnimation.value),
              size: 20,
            ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  isHot
                      ? Colors.red.withOpacity(0.3)
                      : Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isHot ? Colors.red : Colors.green,
                width: isHot ? 3 : 1,
              ),
              boxShadow:
                  isHot
                      ? [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ]
                      : [],
            ),
            child: Icon(Icons.dns, color: isHot ? Colors.red : Colors.green),
          ),
          Text(
            label,
            style: TextStyle(
              color: isHot ? Colors.red : Colors.green,
              fontSize: 10,
            ),
          ),
          Text(
            '${(traffic * 100).toInt()}%',
            style: TextStyle(
              color: isHot ? Colors.red : Colors.green,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  // ============ DATABASE DIAGRAMS ============

  Widget _buildGraphDatabaseDiagram() {
    return _diagramContainer(
      title: 'Graph Database - Relationships',
      child: SizedBox(
        height: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Draw connections
            CustomPaint(
              size: const Size(200, 120),
              painter: _GraphPainter(_pulseAnimation.value),
            ),
            // Nodes
            Positioned(
              left: 80,
              top: 10,
              child: _buildGraphNode('Alice', Colors.blue),
            ),
            Positioned(
              right: 80,
              top: 10,
              child: _buildGraphNode('Bob', Colors.green),
            ),
            Positioned(
              left: 50,
              bottom: 20,
              child: _buildGraphNode('Carol', Colors.orange),
            ),
            Positioned(
              right: 50,
              bottom: 20,
              child: _buildGraphNode('Dave', Colors.purple),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphNode(String label, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(label, style: TextStyle(color: color, fontSize: 9)),
      ),
    );
  }

  Widget _buildTimeSeriesDiagram() {
    return _diagramContainer(
      title: 'Time Series Data',
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            const RotatedBox(
              quarterTurns: 3,
              child: Text(
                'Value',
                style: TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ),
            Expanded(
              child: CustomPaint(
                painter: _TimeSeriesPainter(
                  _progressAnimation.value,
                  widget.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBlobStoreDiagram() {
    return _diagramContainer(
      title: 'Blob Storage - Large Files',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBlobItem(Icons.image, 'Images', Colors.purple),
            _buildBlobItem(Icons.videocam, 'Videos', Colors.red),
            _buildBlobItem(Icons.description, 'Docs', Colors.blue),
            _buildBlobItem(Icons.backup, 'Backups', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildBlobItem(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 10)),
      ],
    );
  }

  Widget _buildObjectStorageDiagram() {
    return _diagramContainer(
      title: 'Object Storage with Metadata',
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Icon(
                Icons.insert_drive_file,
                color: Colors.blue,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Object ID: abc123',
                    style: TextStyle(
                      color: Colors.cyan.withOpacity(_pulseAnimation.value),
                      fontSize: 11,
                    ),
                  ),
                  const Text(
                    'Size: 2.5 MB',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const Text(
                    'Created: 2024-01-15',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const Text(
                    'Content-Type: image/png',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHDFSDiagram() {
    return _diagramContainer(
      title: 'HDFS - Distributed File Storage',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder, color: Colors.amber, size: 24),
                  Text(
                    'Big File',
                    style: TextStyle(color: Colors.amber, fontSize: 9),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            ...List.generate(
              3,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: [
                      Colors.blue,
                      Colors.green,
                      Colors.purple,
                    ][i].withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: [Colors.blue, Colors.green, Colors.purple][i],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.storage,
                        color: [Colors.blue, Colors.green, Colors.purple][i],
                        size: 20,
                      ),
                      Text(
                        'Block ${i + 1}',
                        style: TextStyle(
                          color: [Colors.blue, Colors.green, Colors.purple][i],
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ CONSISTENCY DIAGRAMS ============

  Widget _buildACIDDiagram() {
    return _diagramContainer(
      title: 'ACID Properties',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildACIDProp('A', 'Atomic', Colors.red, 0),
            _buildACIDProp('C', 'Consistent', Colors.blue, 1),
            _buildACIDProp('I', 'Isolated', Colors.green, 2),
            _buildACIDProp('D', 'Durable', Colors.purple, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildACIDProp(String letter, String label, Color color, int index) {
    final isActive = (_progressAnimation.value * 4).floor() == index;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: isActive ? color.withOpacity(0.3) : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: isActive ? 3 : 1),
          ),
          child: Center(
            child: Text(
              letter,
              style: TextStyle(
                color: color,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 9)),
      ],
    );
  }

  Widget _buildBASEDiagram() {
    return _diagramContainer(
      title: 'BASE Model',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBASEProp('BA', 'Basically\nAvailable', Colors.green),
            _buildBASEProp('S', 'Soft\nState', Colors.orange),
            _buildBASEProp('E', 'Eventually\nConsistent', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildBASEProp(String abbr, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color),
            ),
            child: Center(
              child: Text(
                abbr,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 8),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEventuallyConsistentDiagram() {
    final syncProgress = _progressAnimation.value;
    return _diagramContainer(
      title: 'Eventually Consistent',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            final nodeSync = (syncProgress - i * 0.2).clamp(0.0, 1.0);
            final color = nodeSync > 0.8 ? Colors.green : Colors.orange;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.storage, color: color, size: 20),
                      Text(
                        'v${(nodeSync * 3).floor() + 1}',
                        style: TextStyle(color: color, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  nodeSync > 0.8 ? Icons.check_circle : Icons.sync,
                  color: color,
                  size: 16,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStaleDataDiagram() {
    return _diagramContainer(
      title: 'Stale Data Problem',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud,
                  color: Colors.green.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'Source',
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
                const Text(
                  'v3 (new)',
                  style: TextStyle(color: Colors.green, fontSize: 9),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward, color: Colors.grey),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cached, color: Colors.orange, size: 30),
                const Text(
                  'Cache',
                  style: TextStyle(color: Colors.orange, fontSize: 10),
                ),
                Text(
                  'v1 (stale)',
                  style: TextStyle(
                    color: Colors.red.withOpacity(_pulseAnimation.value),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsensusDiagram() {
    return _diagramContainer(
      title: 'Consensus - Nodes Agreeing',
      child: SizedBox(
        height: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(5, (i) {
              final angle = (i * 72 - 90) * 3.14159 / 180;
              final agreed = (_progressAnimation.value * 5).floor() > i;
              return Transform.translate(
                offset: Offset(cos(angle) * 45, sin(angle) * 45),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color:
                        agreed
                            ? Colors.green.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: agreed ? Colors.green : Colors.grey,
                    ),
                  ),
                  child: Icon(
                    agreed ? Icons.check : Icons.help_outline,
                    color: agreed ? Colors.green : Colors.grey,
                    size: 18,
                  ),
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Text(
                '?',
                style: TextStyle(color: Colors.amber, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaxosDiagram() {
    final phase = (_progressAnimation.value * 3).floor();
    return _diagramContainer(
      title: 'Paxos Algorithm Phases',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPaxosPhase('Prepare', phase >= 0, Colors.blue),
            const Icon(Icons.arrow_forward, color: Colors.grey),
            _buildPaxosPhase('Promise', phase >= 1, Colors.orange),
            const Icon(Icons.arrow_forward, color: Colors.grey),
            _buildPaxosPhase('Accept', phase >= 2, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildPaxosPhase(String label, bool active, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? color.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? color : Colors.grey),
      ),
      child: Text(
        label,
        style: TextStyle(color: active ? color : Colors.grey, fontSize: 11),
      ),
    );
  }

  Widget _buildRaftDiagram() {
    return _diagramContainer(
      title: 'Raft - Leader-Based Consensus',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber.withOpacity(_pulseAnimation.value),
                  size: 20,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.amber, width: 2),
                  ),
                  child: const Icon(Icons.dns, color: Colors.amber),
                ),
                const Text(
                  'Leader',
                  style: TextStyle(color: Colors.amber, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.blue.withOpacity(_pulseAnimation.value),
                        size: 16,
                      ),
                      Container(
                        width: 40,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: const Icon(
                          Icons.dns,
                          color: Colors.blue,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderElectionDiagram() {
    final leader = (_progressAnimation.value * 3).floor();
    return _diagramContainer(
      title: 'Leader Election',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final isLeader = leader == i;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLeader)
                    Icon(
                      Icons.emoji_events,
                      color: Colors.amber.withOpacity(_pulseAnimation.value),
                      size: 20,
                    ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color:
                          isLeader
                              ? Colors.amber.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isLeader ? Colors.amber : Colors.grey,
                        width: isLeader ? 2 : 1,
                      ),
                    ),
                    child: Icon(
                      Icons.dns,
                      color: isLeader ? Colors.amber : Colors.grey,
                    ),
                  ),
                  Text(
                    isLeader ? 'Leader' : 'Follower',
                    style: TextStyle(
                      color: isLeader ? Colors.amber : Colors.grey,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildIdempotencyDiagram() {
    return _diagramContainer(
      title: 'Idempotency - Same Result',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '1x',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                Icon(
                  Icons.touch_app,
                  color: Colors.blue.withOpacity(_pulseAnimation.value),
                ),
              ],
            ),
            const SizedBox(width: 20),
            const Text(
              '=',
              style: TextStyle(color: Colors.green, fontSize: 24),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '3x',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                Row(
                  children: List.generate(
                    3,
                    (_) => Icon(
                      Icons.touch_app,
                      color: Colors.blue.withOpacity(_pulseAnimation.value),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Text(
                'Same\nResult',
                style: TextStyle(color: Colors.green, fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ MESSAGING DIAGRAMS ============

  Widget _buildMessageDeliveryDiagram() {
    return _diagramContainer(
      title: 'Message Delivery Semantics',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDeliveryType('At Most Once', '≤1', Colors.blue),
            _buildDeliveryType('At Least Once', '≥1', Colors.orange),
            _buildDeliveryType('Exactly Once', '=1', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryType(String label, String symbol, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color),
          ),
          child: Center(
            child: Text(
              symbol,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 8),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildAtLeastOnceDiagram() {
    return _diagramContainer(
      title: 'At-Least-Once Delivery',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send, color: Colors.blue),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.orange.withOpacity(_pulseAnimation.value),
                        size: 16,
                      ),
                      Icon(
                        Icons.mail,
                        color: Colors.orange.withOpacity(0.7),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Retry ${i + 1}',
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageOrderingDiagram() {
    return _diagramContainer(
      title: 'Message Ordering',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sent',
                  style: TextStyle(color: Colors.blue, fontSize: 10),
                ),
                Row(
                  children: List.generate(
                    3,
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Received',
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
                Row(
                  children: List.generate(
                    3,
                    (i) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplayabilityDiagram() {
    return _diagramContainer(
      title: 'Message Replay',
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.history, color: Colors.purple),
                const SizedBox(width: 8),
                ...List.generate(5, (i) {
                  final isReplaying = (_flowAnimation.value * 5).floor() == i;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color:
                            isReplaying
                                ? Colors.purple.withOpacity(0.5)
                                : Colors.purple.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                        border:
                            isReplaying
                                ? Border.all(color: Colors.purple, width: 2)
                                : null,
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Replaying messages...',
              style: TextStyle(
                color: Colors.purple.withOpacity(_pulseAnimation.value),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStreamingVsRequestDiagram() {
    return _diagramContainer(
      title: 'Streaming vs Request-Response',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Request',
                  style: TextStyle(color: Colors.blue, fontSize: 9),
                ),
                Icon(
                  Icons.swap_horiz,
                  color: Colors.blue.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  '→ Response',
                  style: TextStyle(color: Colors.blue, fontSize: 9),
                ),
              ],
            ),
            Container(
              width: 1,
              height: 60,
              color: Colors.grey.withOpacity(0.3),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Streaming',
                  style: TextStyle(color: Colors.green, fontSize: 9),
                ),
                Transform.translate(
                  offset: Offset(
                    sin(_flowAnimation.value * 3.14159 * 2) * 10,
                    0,
                  ),
                  child: const Icon(
                    Icons.stream,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                const Text(
                  '→→→→→',
                  style: TextStyle(color: Colors.green, fontSize: 9),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============ NETWORK DIAGRAMS ============

  Widget _buildHTTPDiagram() {
    final phase = (_progressAnimation.value * 3).floor();
    return _diagramContainer(
      title: 'HTTP Request/Response',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.computer, color: Colors.blue, size: 30),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'GET /api',
                      style: TextStyle(
                        color: phase == 0 ? Colors.green : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: phase == 0 ? Colors.green : Colors.grey,
                      size: 14,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: phase >= 1 ? Colors.blue : Colors.grey,
                      size: 14,
                    ),
                    Text(
                      '200 OK',
                      style: TextStyle(
                        color: phase >= 1 ? Colors.blue : Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 10),
            const Icon(Icons.dns, color: Colors.purple, size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildIPDiagram() {
    return _diagramContainer(
      title: 'IP Addressing',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '192.168.1.1',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'Local IP',
                    style: TextStyle(color: Colors.blue, fontSize: 9),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.public,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
              size: 30,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '8.8.8.8',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'Public IP',
                    style: TextStyle(color: Colors.green, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolStackDiagram() {
    return _diagramContainer(
      title: 'Protocol Stack (OSI)',
      child: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProtocolLayer('Application', Colors.purple, 0),
            _buildProtocolLayer('Transport', Colors.blue, 1),
            _buildProtocolLayer('Network', Colors.green, 2),
            _buildProtocolLayer('Link', Colors.orange, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildProtocolLayer(String name, Color color, int index) {
    final isActive = (_progressAnimation.value * 4).floor() == index;
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 4),
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.4) : color.withOpacity(0.2),
        border: Border.all(color: color),
      ),
      child: Text(
        name,
        style: TextStyle(color: color, fontSize: 11),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSymmetricEncryptionDiagram() {
    return _diagramContainer(
      title: 'Symmetric Encryption',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description,
              color: Colors.blue.withOpacity(_pulseAnimation.value),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.add, color: Colors.grey),
            const SizedBox(width: 8),
            const Icon(Icons.key, color: Colors.amber),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Colors.grey),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Icon(Icons.lock, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAsymmetricEncryptionDiagram() {
    return _diagramContainer(
      title: 'Asymmetric Encryption',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.vpn_key,
                  color: Colors.green.withOpacity(_pulseAnimation.value),
                ),
                const Text(
                  'Public',
                  style: TextStyle(color: Colors.green, fontSize: 9),
                ),
                const Text(
                  'Encrypt',
                  style: TextStyle(color: Colors.green, fontSize: 8),
                ),
              ],
            ),
            const SizedBox(width: 20),
            const Icon(Icons.lock_outline, color: Colors.grey, size: 30),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.key,
                  color: Colors.red.withOpacity(_pulseAnimation.value),
                ),
                const Text(
                  'Private',
                  style: TextStyle(color: Colors.red, fontSize: 9),
                ),
                const Text(
                  'Decrypt',
                  style: TextStyle(color: Colors.red, fontSize: 8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPublicPrivateKeyDiagram() {
    return _diagramContainer(
      title: 'Key Pair',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Column(
                children: [
                  Icon(Icons.vpn_key, color: Colors.green),
                  Text(
                    'Public',
                    style: TextStyle(color: Colors.green, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Icon(
              Icons.link,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: const Column(
                children: [
                  Icon(Icons.key, color: Colors.red),
                  Text(
                    'Private',
                    style: TextStyle(color: Colors.red, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMITMDiagram() {
    return _diagramContainer(
      title: 'Man-in-the-Middle Attack',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, color: Colors.blue, size: 30),
            Icon(
              Icons.arrow_forward,
              color: Colors.blue.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: const Icon(Icons.person_outline, color: Colors.red),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.blue.withOpacity(_pulseAnimation.value),
            ),
            const Icon(Icons.dns, color: Colors.green, size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProxyDiagram() {
    return _diagramContainer(
      title: 'Proxy Server',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.computer, color: Colors.blue),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: const Icon(Icons.shield, color: Colors.amber),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            const Icon(Icons.dns, color: Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildForwardProxyDiagram() {
    return _diagramContainer(
      title: 'Forward Proxy - Client Side',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Icon(
                    Icons.computer,
                    color: Colors.blue.withOpacity(_pulseAnimation.value),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_outline, color: Colors.orange),
                  Text(
                    'Forward',
                    style: TextStyle(color: Colors.orange, fontSize: 9),
                  ),
                  Text(
                    'Proxy',
                    style: TextStyle(color: Colors.orange, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.public, color: Colors.green, size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildReverseProxyDiagram() {
    return _diagramContainer(
      title: 'Reverse Proxy - Server Side',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.blue.withOpacity(_pulseAnimation.value),
              size: 30,
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield, color: Colors.purple),
                  Text(
                    'Reverse',
                    style: TextStyle(color: Colors.purple, fontSize: 9),
                  ),
                  Text(
                    'Proxy',
                    style: TextStyle(color: Colors.purple, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    width: 35,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green),
                    ),
                    child: const Icon(Icons.dns, color: Colors.green, size: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ RELIABILITY DIAGRAMS ============

  Widget _buildHighAvailabilityDiagram() {
    return _diagramContainer(
      title: 'High Availability (99.99%)',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) {
            final isActive = i <= 1;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color:
                          isActive
                              ? Colors.green.withOpacity(0.3)
                              : Colors.red.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isActive ? Colors.green : Colors.red,
                      ),
                    ),
                    child: Icon(
                      isActive ? Icons.check : Icons.close,
                      color: isActive ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(
                    Icons.circle,
                    color:
                        isActive
                            ? Colors.green.withOpacity(_pulseAnimation.value)
                            : Colors.red,
                    size: 10,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildFaultToleranceDiagram() {
    return _diagramContainer(
      title: 'Fault Tolerance',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red),
                  Text(
                    'Failed',
                    style: TextStyle(color: Colors.red, fontSize: 9),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.amber.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.autorenew, color: Colors.green),
                  Text(
                    'Failover',
                    style: TextStyle(color: Colors.green, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedundancyDiagram() {
    return _diagramContainer(
      title: 'Redundancy - Multiple Copies',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue.withOpacity(_pulseAnimation.value),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.content_copy,
                      color: Colors.blue,
                      size: 20,
                    ),
                    Text(
                      'Copy ${i + 1}',
                      style: const TextStyle(color: Colors.blue, fontSize: 9),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSLADiagram() {
    return _diagramContainer(
      title: 'Service Level Agreement',
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    '99.9% Uptime',
                    style: TextStyle(
                      color: Colors.green.withOpacity(_pulseAnimation.value),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '= 8.76 hours downtime/year',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSLODiagram() {
    return _diagramContainer(
      title: 'Service Level Objective',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSLOMetric('Latency', '<100ms', Colors.blue),
            _buildSLOMetric('Uptime', '99.9%', Colors.green),
            _buildSLOMetric('Error', '<0.1%', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildSLOMetric(String name, String value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: TextStyle(color: color, fontSize: 10)),
      ],
    );
  }

  Widget _buildDDoSDiagram() {
    return _diagramContainer(
      title: 'DDoS Attack',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Icon(
                    Icons.computer,
                    color: Colors.red.withOpacity(_pulseAnimation.value),
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (_) => Icon(Icons.arrow_forward, color: Colors.red, size: 14),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dns, color: Colors.red),
                  Text(
                    'Overload',
                    style: TextStyle(color: Colors.red, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ REAL-WORLD SYSTEMS DIAGRAMS ============

  Widget _buildDropboxDiagram() {
    return _diagramContainer(
      title: 'Dropbox - File Sync',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDeviceIcon(Icons.computer, 'PC', Colors.blue),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sync,
                  color: Colors.cyan.withOpacity(_pulseAnimation.value),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Icon(Icons.cloud, color: Colors.blue, size: 30),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sync,
                  color: Colors.cyan.withOpacity(_pulseAnimation.value),
                ),
              ],
            ),
            _buildDeviceIcon(Icons.phone_android, 'Mobile', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceIcon(IconData icon, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 30),
        Text(label, style: TextStyle(color: color, fontSize: 9)),
      ],
    );
  }

  Widget _buildFacebookDiagram() {
    return _diagramContainer(
      title: 'Facebook - Social Graph',
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ...List.generate(4, (i) {
              final angle = i * 90 * 3.14159 / 180;
              return Transform.translate(
                offset: Offset(cos(angle) * 40, sin(angle) * 30),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue.withOpacity(_pulseAnimation.value),
                    ),
                  ),
                  child: const Icon(Icons.person, color: Colors.blue, size: 18),
                ),
              );
            }),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.hub, color: Colors.white, size: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWhatsAppDiagram() {
    return _diagramContainer(
      title: 'WhatsApp - Messaging',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, color: Colors.green, size: 30),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(_flowAnimation.value * 40 - 20, 0),
                  child: const Icon(Icons.mail, color: Colors.green, size: 20),
                ),
                const SizedBox(height: 8),
                Transform.translate(
                  offset: Offset(20 - _flowAnimation.value * 40, 0),
                  child: const Icon(Icons.mail, color: Colors.blue, size: 20),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.person, color: Colors.blue, size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildYouTubeDiagram() {
    return _diagramContainer(
      title: 'YouTube - Video Streaming',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: const Icon(Icons.videocam, color: Colors.red, size: 24),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple),
              ),
              child: const Icon(Icons.cloud, color: Colors.purple, size: 24),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Icon(Icons.tv, color: Colors.blue, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockTradingDiagram() {
    return _diagramContainer(
      title: 'Stock Trading - Real-time',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.trending_up,
                  color: Colors.green.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'BUY',
                  style: TextStyle(color: Colors.green, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '\$145.23',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'AAPL',
                    style: TextStyle(color: Colors.amber, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.trending_down,
                  color: Colors.red.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'SELL',
                  style: TextStyle(color: Colors.red, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============ TECHNOLOGY DIAGRAMS ============

  Widget _buildRedisDiagram() {
    return _diagramContainer(
      title: 'Redis - In-Memory Cache',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.storage, color: Colors.grey),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.memory, color: Colors.red),
                  Text(
                    'Redis',
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.green.withOpacity(_pulseAnimation.value),
            ),
            const Icon(Icons.bolt, color: Colors.amber),
          ],
        ),
      ),
    );
  }

  Widget _buildKafkaDiagram() {
    return _diagramContainer(
      title: 'Kafka - Message Streaming',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Icon(
                    Icons.send,
                    color: Colors.blue.withOpacity(_pulseAnimation.value),
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: _progressAnimation.value * 3.14159 * 2,
                    child: const Icon(Icons.sync_alt, color: Colors.orange),
                  ),
                  const Text(
                    'Kafka',
                    style: TextStyle(color: Colors.orange, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Icon(
                    Icons.mail,
                    color: Colors.green.withOpacity(_pulseAnimation.value),
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZooKeeperDiagram() {
    return _diagramContainer(
      title: 'ZooKeeper - Coordination',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    width: 35,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: const Icon(Icons.dns, color: Colors.blue, size: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.green.withOpacity(_pulseAnimation.value),
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_tree, color: Colors.green),
                  Text(
                    'ZK',
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNginxDiagram() {
    return _diagramContainer(
      title: 'Nginx - Web Server / Proxy',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Icon(
                    Icons.person,
                    color: Colors.blue.withOpacity(_pulseAnimation.value),
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.router, color: Colors.green),
                  Text(
                    'Nginx',
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    width: 40,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.purple),
                    ),
                    child: const Icon(
                      Icons.dns,
                      color: Colors.purple,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEtcdDiagram() {
    return _diagramContainer(
      title: 'Etcd - Distributed Key-Value Store',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    color: Colors.blue.withOpacity(_pulseAnimation.value),
                  ),
                  const Text(
                    'Config',
                    style: TextStyle(color: Colors.blue, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.cyan.withOpacity(_pulseAnimation.value),
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.storage, color: Colors.cyan),
                  Text(
                    'etcd',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Center(
                      child: Text(
                        'k:v',
                        style: TextStyle(color: Colors.green, fontSize: 8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMySQLDiagram() {
    return _diagramContainer(
      title: 'MySQL - Relational Database',
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'ID',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.orange.withOpacity(0.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.grey.withOpacity(_pulseAnimation.value),
                          fontSize: 9,
                        ),
                      ),
                      const Text(
                        'John',
                        style: TextStyle(color: Colors.grey, fontSize: 9),
                      ),
                      const Text(
                        'j@m.com',
                        style: TextStyle(color: Colors.grey, fontSize: 9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostgreSQLDiagram() {
    return _diagramContainer(
      title: 'PostgreSQL - Advanced RDBMS',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue.withOpacity(_pulseAnimation.value),
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.table_chart, color: Colors.blue, size: 30),
                  Text(
                    'PostgreSQL',
                    style: TextStyle(color: Colors.blue, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFeatureChip('JSONB', Colors.green),
                _buildFeatureChip('Full-text', Colors.orange),
                _buildFeatureChip('Extensions', Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureChip(String label, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 9)),
    );
  }

  Widget _buildNeo4jDiagram() {
    return _diagramContainer(
      title: 'Neo4j - Graph Database',
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(200, 100),
              painter: _GraphPainter(_pulseAnimation.value),
            ),
            Positioned(
              left: 40,
              top: 20,
              child: _buildNeo4jNode('User', Colors.blue),
            ),
            Positioned(
              right: 40,
              top: 20,
              child: _buildNeo4jNode('Post', Colors.green),
            ),
            Positioned(bottom: 10, child: _buildNeo4jNode('Like', Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _buildNeo4jNode(String label, Color color) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(label, style: TextStyle(color: color, fontSize: 9)),
      ),
    );
  }

  Widget _buildPrometheusDiagram() {
    return _diagramContainer(
      title: 'Prometheus - Metrics & Monitoring',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    width: 40,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: const Icon(Icons.dns, color: Colors.blue, size: 12),
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics, color: Colors.orange),
                  Text(
                    'Prometheus',
                    style: TextStyle(color: Colors.orange, fontSize: 9),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.show_chart,
                color: Colors.green,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildS3Diagram() {
    return _diagramContainer(
      title: 'Amazon S3 - Object Storage',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.withOpacity(_pulseAnimation.value),
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud, color: Colors.orange, size: 30),
                  Text(
                    'S3',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildS3Bucket('images/', Colors.blue),
                _buildS3Bucket('videos/', Colors.green),
                _buildS3Bucket('backups/', Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildS3Bucket(String name, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.folder, color: color, size: 12),
          const SizedBox(width: 4),
          Text(name, style: TextStyle(color: color, fontSize: 9)),
        ],
      ),
    );
  }

  Widget _buildGCSDiagram() {
    return _diagramContainer(
      title: 'Google Cloud Storage',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.withOpacity(_pulseAnimation.value),
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_queue, color: Colors.blue, size: 30),
                  Text(
                    'GCS',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGCSClass('Standard', Colors.green),
                _buildGCSClass('Nearline', Colors.orange),
                _buildGCSClass('Archive', Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGCSClass(String name, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(name, style: TextStyle(color: color, fontSize: 9)),
    );
  }

  Widget _buildHadoopDiagram() {
    return _diagramContainer(
      title: 'Hadoop - Big Data Processing',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dataset, color: Colors.amber, size: 24),
                  Text(
                    'Big Data',
                    style: TextStyle(color: Colors.amber, fontSize: 9),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.yellow.shade700),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: _progressAnimation.value * 3.14159 * 2,
                    child: Icon(Icons.settings, color: Colors.yellow.shade700),
                  ),
                  Text(
                    'Hadoop',
                    style: TextStyle(
                      color: Colors.yellow.shade700,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insights, color: Colors.green, size: 24),
                  Text(
                    'Insights',
                    style: TextStyle(color: Colors.green, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ ADVANCED CONCEPTS DIAGRAMS ============

  Widget _buildMapReduceDiagram() {
    final phase = (_progressAnimation.value * 3).floor();
    return _diagramContainer(
      title: 'MapReduce',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMRPhase('Map', phase >= 0, Colors.blue),
            const Icon(Icons.arrow_forward, color: Colors.grey),
            _buildMRPhase('Shuffle', phase >= 1, Colors.orange),
            const Icon(Icons.arrow_forward, color: Colors.grey),
            _buildMRPhase('Reduce', phase >= 2, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildMRPhase(String name, bool active, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: active ? color.withOpacity(0.3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? color : Colors.grey),
      ),
      child: Text(
        name,
        style: TextStyle(color: active ? color : Colors.grey, fontSize: 11),
      ),
    );
  }

  Widget _buildBatchProcessingDiagram() {
    return _diagramContainer(
      title: 'Batch Processing',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder, color: Colors.blue),
                  Text(
                    'Data',
                    style: TextStyle(color: Colors.blue, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Transform.rotate(
              angle: _progressAnimation.value * 3.14159 * 2,
              child: const Icon(Icons.settings, color: Colors.orange),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.green),
                  Text(
                    'Result',
                    style: TextStyle(color: Colors.green, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAsyncProcessingDiagram() {
    return _diagramContainer(
      title: 'Async Processing',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, color: Colors.blue),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, color: Colors.orange),
                  Text(
                    'Queue',
                    style: TextStyle(color: Colors.orange, fontSize: 9),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.grey.withOpacity(_pulseAnimation.value),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.play_arrow, color: Colors.green),
                  Text(
                    'Worker',
                    style: TextStyle(color: Colors.green, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildP2PDiagram() {
    return _diagramContainer(
      title: 'Peer-to-Peer Network',
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(5, (i) {
            final angle = (i * 72 - 90) * 3.14159 / 180;
            return Transform.translate(
              offset: Offset(cos(angle) * 40, sin(angle) * 35),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.cyan.withOpacity(_pulseAnimation.value),
                  ),
                ),
                child: const Icon(Icons.computer, color: Colors.cyan, size: 18),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildCDNDiagram() {
    return _diagramContainer(
      title: 'CDN - Content Delivery',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Icon(Icons.cloud, color: Colors.blue, size: 30),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.green.withOpacity(_pulseAnimation.value),
                        size: 14,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Icon(
                          Icons.public,
                          color: Colors.green,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEdgeComputingDiagram() {
    return _diagramContainer(
      title: 'Edge Computing',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.cloud, color: Colors.blue, size: 30),
                const Text(
                  'Cloud',
                  style: TextStyle(color: Colors.blue, fontSize: 9),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.orange.withOpacity(_pulseAnimation.value),
                    ),
                  ),
                  child: const Icon(Icons.router, color: Colors.orange),
                ),
                const Text(
                  'Edge',
                  style: TextStyle(color: Colors.orange, fontSize: 9),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.devices,
                  color: Colors.green.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'Devices',
                  style: TextStyle(color: Colors.green, fontSize: 9),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoPDiagram() {
    return _diagramContainer(
      title: 'Points of Presence (PoP)',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud, color: Colors.blue, size: 24),
                  Text(
                    'Origin',
                    style: TextStyle(color: Colors.blue, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.green.withOpacity(_pulseAnimation.value),
                        size: 14,
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        ['NYC', 'LON', 'TOK'][i],
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigManagementDiagram() {
    return _diagramContainer(
      title: 'Configuration Management',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.purple.withOpacity(_pulseAnimation.value),
                  width: 2,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings_applications,
                    color: Colors.purple,
                    size: 24,
                  ),
                  Text(
                    'Config',
                    style: TextStyle(color: Colors.purple, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_forward, color: Colors.grey, size: 14),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: [
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                          ][i].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color:
                                [Colors.blue, Colors.green, Colors.orange][i],
                          ),
                        ),
                        child: Text(
                          ['Server 1', 'Server 2', 'Server 3'][i],
                          style: TextStyle(
                            color:
                                [Colors.blue, Colors.green, Colors.orange][i],
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYAMLDiagram() {
    return _diagramContainer(
      title: 'YAML - Human-Readable Config',
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'server:',
              style: TextStyle(
                color: Colors.cyan.withOpacity(_pulseAnimation.value),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const Text(
              '  port: 8080',
              style: TextStyle(
                color: Colors.green,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const Text(
              '  host: localhost',
              style: TextStyle(
                color: Colors.green,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const Text(
              'database:',
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const Text(
              '  name: myapp',
              style: TextStyle(
                color: Colors.green,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJSONDiagram() {
    return _diagramContainer(
      title: 'JSON - Data Exchange Format',
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '{',
              style: TextStyle(
                color: Colors.grey.withOpacity(_pulseAnimation.value),
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const Text(
              '  "name": "John",',
              style: TextStyle(
                color: Colors.orange,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const Text(
              '  "age": 25,',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const Text(
              '  "active": true',
              style: TextStyle(
                color: Colors.green,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
            const Text(
              '}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureFlagsDiagram() {
    return _diagramContainer(
      title: 'Feature Flags',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFeatureFlag('Feature A', true),
            const SizedBox(width: 12),
            _buildFeatureFlag('Feature B', false),
            const SizedBox(width: 12),
            _buildFeatureFlag('Feature C', true),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureFlag(String name, bool enabled) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 30,
          decoration: BoxDecoration(
            color:
                enabled
                    ? Colors.green.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: enabled ? Colors.green : Colors.grey),
          ),
          child: Align(
            alignment: enabled ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              width: 26,
              height: 26,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: enabled ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            color: enabled ? Colors.green : Colors.grey,
            fontSize: 9,
          ),
        ),
      ],
    );
  }

  // ============ API DESIGN DIAGRAMS ============

  Widget _buildRESTfulDiagram() {
    return _diagramContainer(
      title: 'RESTful API Endpoints',
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRESTMethod('GET', '/users', Colors.green),
            _buildRESTMethod('POST', '/users', Colors.blue),
            _buildRESTMethod('DELETE', '/users/{id}', Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildRESTMethod(String method, String path, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 55,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              method,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            path,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCRUDDiagram() {
    return _diagramContainer(
      title: 'CRUD Operations',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCRUDOp('C', 'Create', Colors.green),
            _buildCRUDOp('R', 'Read', Colors.blue),
            _buildCRUDOp('U', 'Update', Colors.orange),
            _buildCRUDOp('D', 'Delete', Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildCRUDOp(String letter, String label, Color color) {
    final isActive =
        (_progressAnimation.value * 4).floor() ==
        ['C', 'R', 'U', 'D'].indexOf(letter);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? color.withOpacity(0.4) : color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: isActive ? 2 : 1),
          ),
          child: Center(
            child: Text(
              letter,
              style: TextStyle(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color, fontSize: 9)),
      ],
    );
  }

  Widget _buildPaginationDiagram() {
    final currentPage = (_progressAnimation.value * 5).floor();
    return _diagramContainer(
      title: 'Pagination',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.chevron_left, color: Colors.grey),
            ...List.generate(
              5,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color:
                        currentPage == i
                            ? Colors.blue.withOpacity(0.5)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: currentPage == i ? Colors.blue : Colors.grey,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: TextStyle(
                        color: currentPage == i ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthenticationDiagram() {
    final phase = (_progressAnimation.value * 3).floor();
    return _diagramContainer(
      title: 'Authentication Flow',
      child: SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAuthStep(Icons.person, 'Login', phase >= 0, Colors.blue),
            Icon(
              Icons.arrow_forward,
              color: phase >= 1 ? Colors.green : Colors.grey,
            ),
            _buildAuthStep(Icons.vpn_key, 'Token', phase >= 1, Colors.orange),
            Icon(
              Icons.arrow_forward,
              color: phase >= 2 ? Colors.green : Colors.grey,
            ),
            _buildAuthStep(
              Icons.check_circle,
              'Access',
              phase >= 2,
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthStep(IconData icon, String label, bool active, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: active ? color : Colors.grey, size: 24),
        Text(
          label,
          style: TextStyle(color: active ? color : Colors.grey, fontSize: 9),
        ),
      ],
    );
  }

  Widget _buildAuthorizationDiagram() {
    return _diagramContainer(
      title: 'Authorization - Role-Based',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRoleAccess('Admin', [true, true, true], Colors.red),
            _buildRoleAccess('Editor', [true, true, false], Colors.orange),
            _buildRoleAccess('Viewer', [true, false, false], Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleAccess(String role, List<bool> perms, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          role,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        ...['R', 'W', 'D'].asMap().entries.map(
          (e) => Row(
            children: [
              Text(
                e.value,
                style: const TextStyle(color: Colors.grey, fontSize: 9),
              ),
              Icon(
                perms[e.key] ? Icons.check : Icons.close,
                color: perms[e.key] ? Colors.green : Colors.red,
                size: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============ ARCHITECTURE DIAGRAMS ============

  Widget _buildMicroservicesDiagram() {
    return _diagramContainer(
      title: 'Microservices Architecture',
      child: SizedBox(
        height: 100,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildMicroservice('User', Colors.blue),
            _buildMicroservice('Order', Colors.green),
            _buildMicroservice('Payment', Colors.orange),
            _buildMicroservice('Notify', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildMicroservice(String name, Color color) {
    return Container(
      width: 60,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(_pulseAnimation.value)),
      ),
      child: Center(
        child: Text(name, style: TextStyle(color: color, fontSize: 10)),
      ),
    );
  }

  Widget _buildMonolithDiagram() {
    return _diagramContainer(
      title: 'Monolithic Architecture',
      child: SizedBox(
        height: 100,
        child: Center(
          child: Container(
            width: 180,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'UI',
                      style: TextStyle(
                        color: Colors.blue.withOpacity(_pulseAnimation.value),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Logic',
                      style: TextStyle(
                        color: Colors.green.withOpacity(_pulseAnimation.value),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      'Data',
                      style: TextStyle(
                        color: Colors.orange.withOpacity(_pulseAnimation.value),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                const Text(
                  'Single Deployment',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventDrivenDiagram() {
    return _diagramContainer(
      title: 'Event-Driven Architecture',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildEventComponent('Producer', Colors.blue),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_forward,
                  color: Colors.grey.withOpacity(_pulseAnimation.value),
                ),
                Transform.translate(
                  offset: Offset(_flowAnimation.value * 20 - 10, 0),
                  child: const Icon(Icons.email, color: Colors.amber, size: 16),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hub, color: Colors.amber),
                  Text(
                    'Bus',
                    style: TextStyle(color: Colors.amber, fontSize: 9),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, color: Colors.grey),
            _buildEventComponent('Consumer', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildEventComponent(String name, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.widgets, color: color, size: 20),
          Text(name, style: TextStyle(color: color, fontSize: 9)),
        ],
      ),
    );
  }

  Widget _buildServiceMeshDiagram() {
    return _diagramContainer(
      title: 'Service Mesh',
      child: SizedBox(
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 180,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.withOpacity(0.3)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMeshService('A', Colors.blue),
                Icon(
                  Icons.swap_horiz,
                  color: Colors.purple.withOpacity(_pulseAnimation.value),
                ),
                _buildMeshService('B', Colors.green),
                Icon(
                  Icons.swap_horiz,
                  color: Colors.purple.withOpacity(_pulseAnimation.value),
                ),
                _buildMeshService('C', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeshService(String name, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: color,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildAutoScalingDiagram() {
    final serverCount = (1 + (_progressAnimation.value * 3).floor()).clamp(
      1,
      4,
    );
    return _diagramContainer(
      title: 'Auto-Scaling',
      child: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Opacity(
                    opacity: i < serverCount ? 1.0 : 0.2,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            i < serverCount
                                ? Colors.green.withOpacity(0.3)
                                : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: i < serverCount ? Colors.green : Colors.grey,
                        ),
                      ),
                      child: Icon(
                        Icons.dns,
                        color: i < serverCount ? Colors.green : Colors.grey,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Load: ${(_progressAnimation.value * 100).toInt()}%',
              style: TextStyle(
                color: Colors.amber.withOpacity(_pulseAnimation.value),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeoDistributionDiagram() {
    return _diagramContainer(
      title: 'Geo-Distribution',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildRegion('US', Colors.blue),
            _buildRegion('EU', Colors.green),
            _buildRegion('Asia', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildRegion(String name, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(_pulseAnimation.value)),
          ),
          child: Icon(Icons.public, color: color),
        ),
        const SizedBox(height: 4),
        Text(name, style: TextStyle(color: color, fontSize: 10)),
      ],
    );
  }

  Widget _buildDataLocalityDiagram() {
    return _diagramContainer(
      title: 'Data Locality',
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue.withOpacity(_pulseAnimation.value),
                  size: 30,
                ),
                const Text(
                  'User',
                  style: TextStyle(color: Colors.blue, fontSize: 9),
                ),
              ],
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Colors.grey),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.storage, color: Colors.green),
                  Text(
                    'Nearby Data',
                    style: TextStyle(color: Colors.green, fontSize: 9),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.storage, color: Colors.grey),
                  Text(
                    'Far Data',
                    style: TextStyle(color: Colors.grey, fontSize: 9),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for Graph Database visualization
class _GraphPainter extends CustomPainter {
  final double animationValue;

  _GraphPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.blue.withOpacity(0.3 + animationValue * 0.3)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    // Draw connections between nodes
    final positions = [
      Offset(size.width * 0.35, size.height * 0.2),
      Offset(size.width * 0.65, size.height * 0.2),
      Offset(size.width * 0.2, size.height * 0.75),
      Offset(size.width * 0.8, size.height * 0.75),
    ];

    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        canvas.drawLine(positions[i], positions[j], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GraphPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

// Custom Painter for Time Series visualization
class _TimeSeriesPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _TimeSeriesPainter(this.animationValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(0.8)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.5);

    for (double x = 0; x <= size.width * animationValue; x += 5) {
      final y =
          size.height * 0.5 +
          sin(x * 0.05) * size.height * 0.3 +
          sin(x * 0.02) * size.height * 0.1;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);

    // Draw axis
    final axisPaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.5)
          ..strokeWidth = 1;

    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, size.height),
      axisPaint,
    );
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), axisPaint);
  }

  @override
  bool shouldRepaint(covariant _TimeSeriesPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

class TopicDetailScreen extends StatefulWidget {
  final String title;
  final Color color;
  final IconData icon;
  final List<Map<String, String>> subtopics;
  final String whatIs;
  final String whyNecessary;

  const TopicDetailScreen({
    super.key,
    required this.title,
    required this.color,
    required this.icon,
    required this.subtopics,
    this.whatIs = '',
    this.whyNecessary = '',
  });

  @override
  State<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<TopicDetailScreen> {
  Set<int> expandedItems = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // Cozy pixel-like gradient background
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C1810), // Dark brown
              Color(0xFF3D2817), // Medium brown
              Color(0xFF4A3420), // Light brown
              Color(0xFF5C4129), // Tan
            ],
            stops: [0.0, 0.3, 0.7, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Cozy pixel-style stars/dots background
            ...List.generate(40, (index) {
              final random = Random(index);
              return Positioned(
                left: random.nextDouble() * screenWidth,
                top: random.nextDouble() * screenHeight,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE4B5).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
            SafeArea(
              child: Column(
                children: [
                  // Header with back button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A3420),
                            borderRadius: BorderRadius.circular(0),
                            border: Border.all(
                              color: const Color(0xFFFFE4B5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 0,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Padding(
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0xFFFFE4B5),
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: GoogleFonts.saira(
                              textStyle: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFE4B5),
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Topic icon and description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A3420),
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(
                          color: const Color(0xFFFFE4B5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 0,
                            offset: const Offset(3, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: widget.color.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(0),
                              border: Border.all(
                                color: const Color(0xFFFFE4B5),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              widget.icon,
                              color: const Color(0xFFFFE4B5),
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Explore ${widget.subtopics.length} key concepts',
                              style: GoogleFonts.saira(
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFFFE4B5),
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Explanation Section
                  if (widget.whatIs.isNotEmpty ||
                      widget.whyNecessary.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3D2817),
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: widget.color, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 0,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // What is it?
                            if (widget.whatIs.isNotEmpty) ...[
                              Row(
                                children: [
                                  Icon(
                                    Icons.lightbulb_outline,
                                    color: widget.color,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'What is it?',
                                    style: GoogleFonts.saira(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: widget.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.whatIs,
                                style: GoogleFonts.robotoSlab(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFFFE4B5),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                            // Divider
                            if (widget.whatIs.isNotEmpty &&
                                widget.whyNecessary.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Divider(
                                  color: widget.color.withOpacity(0.5),
                                  thickness: 1,
                                ),
                              ),
                            // Why is it necessary?
                            if (widget.whyNecessary.isNotEmpty) ...[
                              Row(
                                children: [
                                  Icon(
                                    Icons.priority_high,
                                    color: widget.color,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Why is it necessary?',
                                    style: GoogleFonts.saira(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: widget.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.whyNecessary,
                                style: GoogleFonts.robotoSlab(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFFFE4B5),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  // Subtopics List
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                        itemCount: widget.subtopics.length,
                        itemBuilder: (context, index) {
                          final subtopic = widget.subtopics[index];
                          final isExpanded = expandedItems.contains(index);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3D2817),
                              borderRadius: BorderRadius.circular(0),
                              border: Border.all(
                                color: const Color(0xFFFFE4B5),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 0,
                                  offset: const Offset(3, 3),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isExpanded) {
                                      expandedItems.remove(index);
                                    } else {
                                      expandedItems.add(index);
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Subtopic title with animated icon and expand indicator
                                      Row(
                                        children: [
                                          // Animated icon for the term
                                          AnimatedTermIcon(
                                            termTitle: subtopic['title'] ?? '',
                                            color: widget.color,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              subtopic['title'] ?? '',
                                              style: GoogleFonts.saira(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFFFE4B5),
                                                  fontFamily: 'monospace',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            isExpanded
                                                ? Icons.expand_less
                                                : Icons.expand_more,
                                            color: const Color(0xFFFFE4B5),
                                            size: 24,
                                          ),
                                        ],
                                      ),

                                      // Expanded content
                                      if (isExpanded) ...[
                                        const SizedBox(height: 12),

                                        // Definition
                                        if (subtopic['definition'] != null) ...[
                                          Text(
                                            subtopic['definition']!,
                                            style: GoogleFonts.saira(
                                              textStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFFFFE4B5),
                                                fontFamily: 'monospace',
                                                height: 1.4,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                        ],

                                        // Animated Diagram - Visual explanation
                                        AnimatedConceptDiagram(
                                          termTitle: subtopic['title'] ?? '',
                                          color: widget.color,
                                        ),
                                        const SizedBox(height: 12),

                                        // Example
                                        if (subtopic['example'] != null) ...[
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2C1810),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              border: Border.all(
                                                color: const Color(0xFFFFD700),
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Example:',
                                                  style: GoogleFonts.saira(
                                                    textStyle: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFFFD700),
                                                      fontFamily: 'monospace',
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  subtopic['example']!,
                                                  style: GoogleFonts.saira(
                                                    textStyle: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xFFFFE4B5),
                                                      fontFamily: 'monospace',
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                        ],

                                        // Importance
                                        if (subtopic['importance'] != null) ...[
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2C1810),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              border: Border.all(
                                                color: widget.color,
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Why it matters:',
                                                  style: GoogleFonts.saira(
                                                    textStyle: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: widget.color,
                                                      fontFamily: 'monospace',
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  subtopic['importance']!,
                                                  style: GoogleFonts.saira(
                                                    textStyle: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0xFFFFE4B5),
                                                      fontFamily: 'monospace',
                                                      height: 1.4,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                        ],

                                        // Additional information
                                        if (subtopic['additional'] != null) ...[
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF2C1810),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              border: Border.all(
                                                color: const Color(0xFF90EE90),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              subtopic['additional']!,
                                              style: GoogleFonts.saira(
                                                textStyle: const TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF90EE90),
                                                  fontFamily: 'monospace',
                                                  height: 1.4,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
