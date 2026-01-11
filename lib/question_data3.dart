import './quiz_question.dart';

const questions3 = [
  QuizQuestion(
    'The following are common server-selection strategies for load balancers (check all that apply):',
    [
      'Client-IP-based.',
      'Server-health-based.',
      'Round-robin.',
      'Compliance-based.',
    ],
    '''
Correct Options
    [Client-IP-based:] This strategy sends requests from the same user to the same server, which is useful for maintaining a consistent user session.

    [Server-health-based:] This is a smart strategy that sends new requests to the healthiest server, preventing any one server from becoming overwhelmed.

    [Round-robin:] This simple method distributes traffic evenly by sending requests to each server in a rotating, sequential order.

Incorrect Option
    [Compliance-based:] This is not a real server-selection strategy; compliance is a high-level business requirement, not a technical decision for a load balancer.
''',
  ),
  QuizQuestion(
    'The following statements are correct (check all that apply):',
    [
      'SLO stands for "service-level objective".',
      'SLAs are made up of one or multiple SLOS.',
      'SLA stands for "service-level agreement".',
      'An SLA must guarantee at least 3 nines of availability.',
    ],
    '''
Correct Options
    [SLO stands for "service-level objective":] An SLO is a specific, measurable goal for a service's performance.

    [SLAs are made up of one or multiple SLOS:] An SLA is a formal contract that commits to meeting the specific, measurable goals defined by one or more SLOs.

    [SLA stands for "service-level agreement":] An SLA is a formal contract between a provider and a customer that defines the expected level of service.

Incorrect Option
    [An SLA must guarantee at least 3 nines of availability:] This is false, as the availability guaranteed in an SLA is negotiated and can be lower or higher than 99.9%.
''',
  ),
  QuizQuestion(
    'Which of the following are usually good ways to split (shard) data? (Check all that apply)',
    [
      'Sharding based on the kind of data.',
      'Sharding based on a customer\'s username.',
      'Sharding based on a client\'s region.',
      'Sharding based on the time the data is stored.',
    ],
    '''
Correct Options
    [Sharding based on the kind of data:] This is a good way to split data because it organizes different types of information into separate databases based on how they're used.

    [Sharding based on a customer's username:] This is effective because it keeps all of one user's data on a single server, making it fast to access their information.

    [Sharding based on a client's region:] This is useful because it puts a user's data on a server that is physically closer to them, reducing latency and improving speed.

Incorrect Option
    [Sharding based on the time the data is stored:] This is a poor method because it sends all new data to a single server, which quickly becomes overwhelmed and creates an unbalanced system.
''',
  ),
  QuizQuestion(
    'You are designing a chat app like WhatsApp. Which of these would you likely include in the system? (Check all that apply)',
    [
      'One or more load balancers to manage sending and receiving messages.',
      'A Pub/Sub system to handle sending messages and read receipts.',
      'A storage system that keeps all past messages.',
      'A peer-to-peer setup so messages can be sent quickly between users.',
    ],
    '''
Correct Options
    [One or more load balancers to manage sending and receiving messages:] Load balancers are essential to distribute the massive traffic of a chat app and prevent any single server from getting overloaded.

    [A Pub/Sub system to handle sending messages and read receipts:] This system is ideal for real-time chat because it efficiently sends messages to multiple users at once.

    [A storage system that keeps all past messages:] A storage system is necessary to save chat history, allowing users to access past conversations and messages.

Incorrect Option
    [A peer-to-peer setup so messages can be sent quickly between users:] This setup is not a good fit because it would fail if a user is offline, and a centralized server is better for managing features like group chats and message history.
''',
  ),
  QuizQuestion(
    'The following technologies are storage solutions (check all that apply):',
    ['Neo4j.', 'MySQL.', 'Prometheus.', 'NginX.'],
    '''
Correct Options
    [Neo4j:] This is a storage solution because it's a graph database designed to store interconnected data.

    [MySQL:] This is a storage solution because it's a relational database used to store structured data in tables.

    [Prometheus:] This is a storage solution because it's a time series database built for storing time-stamped monitoring data.

Incorrect Option
    [NginX:] This is not a storage solution; it's a web server and reverse proxy used to manage network traffic and serve content.
''',
  ),
  QuizQuestion(
    'The following technologies are key-value stores (check all that apply):',
    ['Etcd.', 'ZooKeeper.', 'Redis.', 'Hadoop.'],
    '''
Correct Options
    [Etcd:] A distributed key-value store used for shared configuration and service discovery.

    [ZooKeeper:] A distributed key-value store used for coordination and managing configuration data.

    [Redis:] An in-memory key-value store often used as a high-speed cache and message broker.

Incorrect Option
    [Hadoop:] Not a key-value store; it's a software framework for processing and storing large datasets.
''',
  ),
  QuizQuestion(
    'A hot spot (an overloaded part of the system) can happen when: (Check all that apply)',
    [
      'The system\'s work is unevenly spread out by nature.',
      'The way data is split across databases (sharding key) isn\'t well chosen.',
      'The method used to pick which server to send data to (hashing function) isn\'t well designed.',
      'The main database doesn\'t have backup copies.',
    ],
    '''
Correct Options
    [The system's work is unevenly spread out by nature:] A hot spot occurs when certain data or resources are naturally much more popular and receive most of the traffic.

    [The way data is split across databases (sharding key) isn't well chosen:] A poor sharding key can cause all new or popular data to pile up on a single server, creating an overloaded hot spot.

    [The method used to pick which server to send data to (hashing function) isn't well designed:] A poorly designed hashing function can send an unbalanced amount of requests to one server, causing a hot spot.

Incorrect Option
    [The main database doesn't have backup copies:] Backups are for data recovery, not for preventing a server from being overwhelmed by traffic.
''',
  ),
  QuizQuestion(
    'The following are all real acronyms in the field of systems design (check all that apply):',
    [
      'TCP, SLO, S3, and HDFS.',
      'DoS, YAML, PoP, and RAM.',
      'CDN, SQL, DNS, and IP.',
      'GCS, LTM, HTTP, and ACID.',
    ],
    '''
Correct Options
    [TCP, SLO, S3, and HDFS:] All four are real and common acronyms. TCP is a core networking protocol, SLO is a performance target, S3 is a cloud storage service, and HDFS is a distributed file system.

    [DoS, YAML, PoP, and RAM:] All four are real acronyms. DoS is a type of attack, YAML is a configuration format, PoP is a network location, and RAM is computer memory.

    [CDN, SQL, DNS, and IP:] All four are real and very common acronyms. CDN is a network for serving content, SQL is a database language, DNS is for translating domain names, and IP is a fundamental networking protocol.

Incorrect Options
    [GCS, LTM, HTTP, and ACID:] This option is incorrect because LTM (Long-Term Memory) is a term from psychology, not systems design.
    While the other acronyms are real (GCS for Google Cloud Storage, HTTP for Hypertext Transfer Protocol, and ACID for Atomicity, Consistency, Isolation, Durability),
    the presence of an incorrect term makes the entire statement false.
''',
  ),
  QuizQuestion(
    'Pub/Sub systems typically come with the following guarantees (check all that apply):',
    [
      'Replayability of messages.',
      'At-least-once delivery of messages.',
      'Ordering of messages.',
      'Encryption of messages.',
    ],
    '''
Correct Options
    [Replayability of messages:] Pub/Sub systems can store messages, allowing a subscriber to reprocess them from a specific point in time.

    [At-least-once delivery of messages:] A message is guaranteed to be delivered at least one time, with subscribers handling potential duplicates to ensure no data is lost.

    [Ordering of messages:] Messages from a single sender are guaranteed to be delivered in the correct sequence, which is crucial for applications like chat.

Incorrect Option
    [Encryption of messages:] This is not a core guarantee of the Pub/Sub system itself; it's a security feature that is typically handled by the application layer.
''',
  ),
  QuizQuestion(
    'The following concepts are fake and don\'t exist(check all that apply):',
    [
      'Distributed denial-of-sharding attack',
      'Rendezvous caching',
      'Relational idempotency',
      'Distributed file system',
    ],
    '''
Correct Options
    [Distributed denial-of-sharding attack:] This is a fake term because it incorrectly combines a cyberattack with a data-splitting technique.

    [Rendezvous caching:] This is a fake term that confusingly combines a real hashing technique with a real storage concept.

    [Relational idempotency:] This is a fake term that incorrectly combines a type of database with a property of an operation.

Incorrect Option
    [Distributed file system:] This is a real and widely used concept that allows multiple computers to share and access files as if they were all on a single machine.
''',
  ),
];
