import './quiz_question.dart';

const questions2 = [
  QuizQuestion(
    'Which of the following could realistically cause too much traffic in a system? (Check all that apply)',
    [
      'A social media trend makes lots of people named "bob" or "jacklin" all post " I love system design!" at once.',
      'A large number of users suddenly visit the system from the same region.',
      'The systems load balancer picks servers one by one in a repeating order.',
      'The systems main database fails to copy updates to its backups.',
    ],
    '''Because a social media trend and a large number of users suddenly visiting the system from the same region describe situations that could lead to a sudden, concentrated surge in system traffic.
     The other options are incorrect because they describe a system component or behavior that may cause other issues, but not specifically an excessive amount of traffic.
''',
  ),
  QuizQuestion(
    'When designing an API, what should you always do? (Check all that apply)',
    [
      'Think about what the API needs to do.',
      'Think about who will be using the API.',
      'Only use CRUD or non-CRUD endpoints, but not both.',
      'Make every endpoint return as much data as possible.',
    ],
    '''
Because they represent foundational principles of good API design: functionality and usability. 
Other options are incorrect because they promote rigid or inefficient practices that can severely limit an API's flexibility and performance.
''',
  ),
  QuizQuestion(
    'An asynchronous MapReduce job is likely used to do which of the following? (Check all that apply)',
    [
      'Add up view counts for North American YouTube channels.',
      'Find the most common errors in a web app.',
      'List all hotels available in a certain area.',
      'Check which strings appear in a LinkedIn post from a list of strings.',
    ],
    '''
Because they describe problems that are perfect for a MapReduce job: processing large(view counts for YouTube channels), batch-oriented data for aggregation or analysis(finding errors in a web app). 
Other options are wrong because they describe real-time, singular data lookups that are better handled by a traditional database and not MapReduce job.
''',
  ),
  QuizQuestion(
    'The following are actual types of databases (check all that apply):',
    [
      'Graph database.',
      'Time series database.',
      'Primitive database.',
      'Moving database.',
    ],
    '''
1. [Graph database:] A database that stores data as interconnected nodes and edges, perfect for mapping relationships like those in social networks.
2. [Time series database:] A database built for handling and analyzing data points that arrive in a sequence, each with a timestamp, like stock prices or sensor readings.
3. [Primitive database:] Not a real type of database; "primitive" refers to the most basic data building blocks like numbers or letters, which are stored within all databases.
4. [Moving database:] Not a type of database, but rather the process of transferring data from one database to another.''',
  ),
  QuizQuestion(
    'The following are reasons to replicate a database in a system (check all that apply):',
    [
      'To move data closer to a set of clients so as to improve latency for those clients.',
      'To make the system more fault-tolerant.',
      'To add a layer of caching to the system.',
      'To load balance the system.',
    ],
    '''
[Why they're correct:]
    {To improve latency:} Replicating a database places a copy closer to users, which reduces the time it takes for data to travel and improves access speed.

    {To improve fault tolerance:} If one database server fails, a replicated copy can immediately take over, ensuring the system remains available and reliable.

[Why they're wrong:]
    {To add caching:} This is incorrect because caching and replication are different; caching stores frequently accessed data for faster retrieval,
    while replication creates a full copy of the database for redundancy and proximity.

    {To load balance:} This is incorrect because replication provides the multiple copies needed for a load balancer to work,
    but the act of replication itself isn't load balancing; a separate load balancer tool is used to distribute the traffic.
''',
  ),
  QuizQuestion(
    'The following features lend themselves well to streaming (check all that apply):',
    [
      'Watching videos on YouTube.',
      'Sending and receiving messages on Slack.',
      'Browsing through products on Amazon.',
      'Running code on a website.',
    ],
    '''
[Correct Options]
    {Watching videos on YouTube:} This is a classic example of streaming because video data is delivered to your device in a continuous flow, allowing you to start watching instantly without downloading the entire file.

    {Sending and receiving messages on Slack:} This is a form of streaming because data is pushed and received in real-time, enabling live communication without needing to manually refresh the page.

[Incorrect Options]
    {Browsing through products on Amazon:} This is not streaming; it operates on a request-response model where your browser asks for a specific page and the server sends it back in a single data exchange.

    {Running code on a website:} This is typically a request-response task where you send code to a server and it returns the final result, rather than providing a continuous data stream.
  ''',
  ),
  QuizQuestion(
    'Which of the following statements are true? (Check all that apply)',
    [
      'You can make a simple rate-limiting service yourself using a key-value store.',
      'Without good protection, a DoS attack can bring down a whole system.',
      'Regular DDoS attacks can be stopped easily by limiting how often people can send requests.',
      'Backup systems can completely protect against DoS attacks.',
    ],
    '''
[Correct Options]
    {You can make a simple rate-limiting service yourself using a key-value store:} A key-value store can easily track and count requests from a user, making it a simple tool for building a rate-limiting service.

    {Without good protection, a DoS attack can bring down a whole system:} A DoS attack overloads a system with so much traffic that it exhausts resources, making it crash or become unavailable.

[Incorrect Options]
    {Regular DDoS attacks can be stopped easily by limiting how often people can send requests:} DDoS attacks use many different sources, so simple rate-limiting on a single IP address is not an effective defense.

    {Backup systems can completely protect against DoS attacks:} Backups protect against data loss, not against an attack that floods the system and makes it unavailable.
  ''',
  ),
  QuizQuestion(
    'The following are realistic examples of config(check all that apply):',
    [
      '''locations: 
            - us-central-1
            - europe-west-1
            - europe-west-2
      restrictionsOn: true''',
      '''{
  "apikey": "HgebdkUGFkkwrl148jD",
  "displayAccountExpiration": true,
  "expirationDate":"2020-09-15T00:00:00z",
  "updatePollInterval": 100000
}''',
      'const allowAccess = config.profileLaunched && res.code === 200;\nconst {timeToExpire} = res.data;',
      '## Changing Parameters\nIf you\'re changing a parameter, make sure to contact the appropriate feature owner first. You can find feature-owner contact information above each parameter. If no contact information is present, you don\'t have to contact anyone.',
    ],
    '''
[Correct Options]
    {YAML format:} This is a classic example of a configuration file in YAML, which uses a clean, indented format to define application settings like locations and restrictions.

    {JSON format:} This is a standard configuration file in JSON, which uses key-value pairs to store and organize various application settings.

[Incorrect Options]
    {Code, not config:} This is not a configuration; it is JavaScript code that uses configuration values to perform an action.

    {Documentation, not config:} This is not a configuration file; it is a text document with instructions for humans on how to change parameters.
  ''',
  ),
  QuizQuestion(
    'The following statements are correct(check all that apply)',
    [
      'Paxos and raft are consensus algorithms',
      'Etcd and zookeeper are key value stores',
      'Neo4j and postgress are SQL database',
      'Kafka and hadoop are Pub/sub technologies',
    ],
    '''
[Correct Options]
    {Paxos and Raft are consensus algorithms:} They are both designed to help computers in a network agree on a single value to ensure data consistency.

    {Etcd and Zookeeper are key-value stores:} They are both used to store and manage configuration data in distributed systems.

[Incorrect Options]
    {Neo4j and Postgres are SQL databases:} This is wrong because Neo4j is a NoSQL graph database, not an SQL database.

    {Kafka and Hadoop are Pub/sub technologies:} This is wrong because while Kafka is a pub/sub technology, Hadoop is a framework for data processing and storage, not a messaging system.
  ''',
  ),
  QuizQuestion(
    'You would likely want to use a cache in the following systems-design scenarios(check all that apply):',
    [
      'Users accessing articles on an online-newspaper website',
      'Users accessing static content on the home page of a website',
      'Users accessing code they\'ve written for questions on QuizWebsite',
      'Users accessing their saved credit-card information on Amazon',
    ],
    '''
[Correct Options]
    {Users accessing articles on an online-newspaper website:} Articles are read by many people but rarely change, making them perfect for a cache to quickly serve repeated requests.

    {Users accessing static content on the home page of a website:} This content is accessed by every visitor and rarely changes, so caching it drastically improves load times and performance.

[Incorrect Options]
    {Users accessing code they've written for questions on QuizWebsite:} This data is unique to each user and changes frequently, making it a poor candidate for caching as it would often be outdated.

    {Users accessing their saved credit-card information on Amazon:} This is highly sensitive data that should be fetched directly from a secure database to minimize security risks, not stored in a cache.
  ''',
  ),
  QuizQuestion(
    'Which of these are true about peer-to-peer (P2P) systems? (Check all that apply)',
    [
      'They don\'t have the traffic slowdowns that one-server systems can have.',
      'They can use more of the network\'s total speed.',
      'They are safer than systems with one main server.',
      'They are easier to fix than systems with one main server.',
    ],
    '''
[Correct Options]
    {They don't have the traffic slowdowns that one-server systems can have:} P2P systems distribute the data load across many computers, preventing a single server from getting overwhelmed.

    {They can use more of the network's total speed:} Users can download different parts of a file from multiple sources at once, combining their speeds for faster downloads.

[Incorrect Options]
    {They are safer than systems with one main server:} P2P systems can be less safe because there's no central authority to scan for malicious files and every peer is a potential entry point for viruses.

    {They are easier to fix than systems with one main server:} P2P systems are harder to debug because a problem could be with any of the thousands of peers, not a single, centralized server.
  ''',
  ),
  QuizQuestion(
    'If you wanted to minimize latency in a system, you would want to do the following(check all that apply):',
    [
      'Maximize cache hits',
      'Move system servers closer to clients',
      'Read data from persistent storage instead of from memory',
      'Route network requests through multiple reverse proxies.',
    ],
    '''
[Correct Options]
    {Maximize cache hits:} This is correct because retrieving data from a fast cache is much quicker than getting it from a slow main database, directly reducing latency.

    {Move system servers closer to clients:} This is correct because reducing the physical distance data has to travel directly shortens the time it takes to reach the user.

[Incorrect Options]
    {Read data from persistent storage instead of from memory:} This is wrong because persistent storage is significantly slower than memory, so doing this would increase latency.

    {Route network requests through multiple reverse proxies:} This is wrong because each additional proxy adds a processing step, which increases the total time for the request to reach its destination.
  ''',
  ),
];
