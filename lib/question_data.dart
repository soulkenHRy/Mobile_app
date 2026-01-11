import './quiz_question.dart';

const questions1 = [
  QuizQuestion(
    'Which of the following puts these actions in order from fastest to slowest?',
    [
      'Read from memory (RAM) < Read from SSD < Send over internet < Send across the world.',
      'Send across the world < Send over internet < Read from SSD < Read from memory (RAM).',
      'Read from memory (RAM) < Send over internet < Send across the world < Read from SSD.',
      'Read from SSD < Read from memory (RAM) < Send over internet < Send across the world.',
    ],
    '''
  To put it simply, getting information from a computer is all about speed and distance. The closer the information is, the faster you can get it.

  [1. Read from memory (RAM): The Fastest]
    => This is like grabbing a snack from your pocket. The data is already in the computer's short-term memory (RAM), right next to the brain (CPU). It's super fast because there's almost no distance for the data to travel.

  [2. Read from SSD: A Little Slower]
    => This is like getting a snack from the fridge in the same room. The data is stored on a hard drive (SSD), which is still inside the computer but a little farther away than RAM. It's very fast, but not quite as instant as RAM.

  [3. Send over the Internet: Even Slower]
    => This is like getting a snack delivered from a store in your town. The data has to travel through a network to get from another computer (a server) to yours. This takes more time because of the distance and all the stops (routers) it has to make along the way.

  [4. Send across the world: The Slowest]
    => This is like getting a snack shipped from a different country. The data has to travel a huge distance, crossing oceans and continents. This long journey, even at the speed of light, makes it the slowest way to get information.

  So, the order from fastest to slowest is: Read from memory (RAM) < Read from SSD < Send over internet < Send across the world.
    ''',
  ),
  QuizQuestion(
    'Which of these actions is NOT usually part of a basic CRUD (Create, Read, Update, Delete) API?',
    ['Move something.', 'List things.', 'Get something.', 'Create something.'],
    '''
    A CRUD API is a set of rules for managing data. CRUD stands for Create, Read, Update, and Delete. These are the four basic actions you can perform on any data.

    The action 'Move something' is not a core CRUD operation because it's usually a combination of other more actions, like reading the data and then updating its location, so the action that takes one or more basic CURD operations is not part of basic CURD API, it(move) comes in more complex part.
    So, while you can move something by using CRUD operations, 'Move' itself is not one of the basic actions defined in CRUD.
    ''',
  ),
  QuizQuestion(
    'Which of the following statements is correct?',
    [
      'A database that is eventually consistent might give old (stale) data when you read from it.',
      'All key-value databases always give the most up-to-date data.',
      'An index in a database makes writing data much faster.',
      'Saving data to the hard drive is the same as saving it to memory.',
    ],
    '''
[Why is 'A database that is eventually consistent might give old (stale) data when you read from it.' correct?]
	=> {Idempotent operations:} are the kind of operations which even when repeated multiple times doesn't effect the result ( for example: 'A data base with the name 'Alex' got deleted, and
	now we try to delete it again, no matter how many times we delete it won't change a thing cause it is no more there after the first deletion')
''',
  ),
  QuizQuestion(
    'Which of the following statements is correct?',
    [
      'Operations that can safely be repeated (idempotent) are not a big issue in a Pub/Sub system.',
      'A high-quality production database must support ACID transactions.',
      'An in-memory cache can permanently store data.',
      'A system that goes down for 1 hour every week can still have 99.999% (five nines) availability.',
    ],
    '''
  A Pub/Sub (Publish/Subscribe) system is a messaging pattern where {"publishers"}(pub) send messages to different news and {"subscribers"}(sub) receive messages from those news. These systems often
	guarantee "at least once" delivery to ensure no messages are lost. This means a subscriber might receive the same message more than once.

	Because idempotent operations can be repeated without consequence, they are perfect for Pub/Sub system. If a message containing an idempotent operation, like "update user profile
	picture," is delivered twice, the subscriber can safely process it both times. The final state (the user's profile picture) will be correct. This simplifies error handling and makes
	the system more resilient to network issues and failures, as retries are always safe.

[Why the rest options are wrong?]
	=> {Databases don't always need ACID.} While ACID (Atomicity, Consistency, Isolation, Durability) is important for some databases, many modern databases prioritize speed and
	availability over strict consistency. They use the BASE model instead.

	=> {An in-memory cache can't permanently store data.} It uses RAM, which is volatile memory. Data is erased when the power is turned off.

	=> {99.999% availability is extremely high.} A system can't have this level of availability if it's down for one hour every week, which is a total of 52 hours of downtime per year.
	This is far more than the roughly five minutes of downtime allowed for a 99.999% availability target.
''',
  ),
  QuizQuestion(
    'You are designing Dropbox, where users store files like videos, images, and documents, plus info about those files like size, uploader, and last edit time. Which storage types would you most likely use for the files and their info?',
    [
      'Use a blob store for the files and a key-value store for the info.',
      'Use a key-value store for the files and a blob store for the info.',
      'Use a SQL database for the files and a blob store for the info.',
      'Use a SQL database for both the files and the info.',
    ],
    '''
  => blob(Binary Large Object store) is specifically designed to handle large, unstructured data like videos, images, and documents. A blob storage is like a massive storage room where
	you can store anything, this makes them perfect for the core function of dropbox, which is storing the files, they also provide a Unique identifier(like a URL) to access it. 

	A key-value store is a type of NoSQL database that stores data as a collection of key-value pairs. Each item has a unique key (like a file's ID or path) that points to a value (the
	file's metadata).

	Combining these two creates a powerful and efficient system: the key-value store provides fast lookups for file info, which then points to the actual file stored in the scalable
	blob store.

[Using a Key-Value Store for files and a Blob Store for info and Why is it wrong?]
	= This is a backward way of doing things and doesn't work well. Think of a key-value store as a bunch of lockers, but each locker is really small. You can put a key on the locker to
	know what's inside, but you can only put tiny things in it, like a note or a toy car. A large file, like a big video, is like a bicycle. It won't fit in the tiny locker. So, trying
	to use a key-value store for big files is a bad idea because it's not made for that.

And using a blob store for small info is like using a huge garage to store just a single key. It's a waste of space and doesn't make sense.

[Using a SQL Database for files and a Blob Store for info, and why is it wrong?]
	= A SQL database is like a really organized filing cabinet with lots of folders and dividers. It's great for keeping track of things that are neat and structured, like a list of
	students and their grades.
	It's not good for storing big, messy things like a whole pile of clothes. You could technically cram a big video file into a SQL database, but it's like trying to shove all your
	clothes into one drawer of the filing cabinet. It'll make everything slow and messy, and it's hard to find anything later. It's better to use a system that's built for large files.

[Using a SQL Database for both files and info, and why is it wrong?]
	= This is the worst choice of all. It's like trying to use that filing cabinet to store both the clothes and the information about them. The filing cabinet would become so full and
	disorganized that it would be impossible to use. It would get very slow, and it would be really hard to add new things.
    ''',
  ),
  QuizQuestion(
    'When is caching usually not a good idea?',
    [
      'When the data is updated everytime.',
      'When you want to reduce how often the database is read.',
      'When you want to make the system respond faster.',
      'When many users are looking at the same data.',
    ],
    '''
  Caching is like keeping your favorite books on a small shelf next to your desk instead of walking to a huge library every time. 
  It makes getting information faster by storing frequently used data in a temporary, easy-to-access location.

  Caching is not a good idea when the data changes constantly, like with a daily newspaper, because the cached information will quickly become outdated.
  ''',
  ),
  QuizQuestion(
    'Leader election is used in systems to achieve the following goal:',
    [
      'High availability.',
      'High throughput.',
      'Consistent hashing.',
      'Low latency.',
    ],
    '''
    {Leader election} is a process for a group of computers to automatically select a new leader if the current one fails. 
    This is crucial for {high availability}, which ensures a system remains operational even if parts of it break.

    [Why Other Concepts Aren't the Answer]
      => {High throughput} is about maximizing the amount of work a system can do, not preventing it from stopping.

      => {Consistent hashing} is a method for distributing data efficiently, not for handling computer failures.

      => {Low latency} focuses on minimizing response time, whereas leader election is about preventing total system failure, which can actually introduce a slight delay.
    ''',
  ),
  QuizQuestion(
    'The following statement is correct:',
    [
      'Hitting the same API endpoint every ten minutes is an example of polling.',
      'High throughput guarantees low latency.',
      'A reverse proxy is a special type of load balancer.',
      'A blob store is a SQL database.',
    ],
    '''
    [Polling:]
      Polling is a method where a client repeatedly sends a request to a server to check for new information. 
      It's like checking your mailbox every few minutes for a letter instead of waiting for the mail carrier to notify you.
      So hitting the same API endpoint every ten minutes is indeed an example of polling.

    [High throughput guarantees low latency and this statement is wrong.]
      {What is Throughput and Latency?}
        = Throughput is the total amount of work a system can complete in a given time, like the number of customers a store can check out in an hour.
        = Latency is the time it takes to complete a single task, like how long one customer waits in line.

      High throughput doesn't guarantee low latency. A system can handle many tasks overall (high throughput) while a specific task takes a long time to complete (high latency). 
      For instance, a store with many cashiers has high throughput, but a customer with a full shopping cart will still have high latency.

    [A reverse proxy is a special type of load balancer and this statement is wrong.]
        A load balancer is a type of reverse proxy, but a reverse proxy isn't a load balancer. 
        A load balancer is a type of reverse proxy because it performs one of the key functions of a reverse proxy: distributing traffic. 
        A reverse proxy, however, is a more general term for a server that handles incoming requests for other servers. 
        It can perform many tasks besides just traffic distribution, such as security, SSL termination, and caching. 
        Therefore, while every load balancer is a reverse proxy, not every reverse proxy is a load balancer, as it may be used for other purposes.

    [A blob store is a SQL database and this statement is wrong.]
      = Think of a SQL database as an organized filing cabinet, perfect for neat information like customer details. Everything has its own labeled folder and specific place.

      = A blob store is more like a big toy chest. It's for storing large, messy things like images and videos, without needing any special organization.
''',
  ),
  QuizQuestion(
    'Which of the following is often used to quickly search location-based (spatial) data?',
    ['A quadtree.', 'A shard.', 'A geofence.', 'A SQL database.'],
    '''
[Why quadtree is the correct answer?]
	= Imagine you have a big map of a city, and you want to find all the pizza places in just one small neighborhood.
	A quadtree is like a special, super-organized file cabinet for maps. Instead of just putting all the addresses in one big messy pile, a quadtree divides the map into smaller and
	smaller boxes. It's like cutting a big square pizza into four smaller squares, and then cutting those smaller squares into four even smaller ones, and so on.

	When you want to find all the pizza places in one neighborhood, you don't have to look through the entire city map. You just go to the specific drawer (or 'quadrant') that holds
	that neighborhood's information. This makes finding what you're looking for much, much faster.

[Why a Shard is not the answer?]
	= A shard is like having lots of different maps of the city, and each one only shows a certain part. For example, one map might show the north side, and another might show the south
	side. This is great for sharing the work with other people, but it doesn't help you quickly find a specific spot within just one of those maps. It's a way to spread out the work,
	not a way to find a location quickly.

[Why a Geofence is not the answer?]
	= A geofence is like drawing a magic line around a specific area, like a park. When your phone crosses that line, a message pops up. It's a boundary, not a way to search for things
	inside that boundary. It's like a doorbell for a specific place, not a search engine.

[Why a SQL Database is not the answer?]
	= A SQL database is like a big, long list of all the addresses and pizza places in the whole city, written down on a scroll. If you want to find all the pizza places on a certain
	street, you have to read the entire list, from top to bottom, until you find all of them. This can take a long, long time, especially if the list is huge. A quadtree is much faster
	because it organizes the addresses so you don't have to look at everything.
''',
  ),
  QuizQuestion(
    'You\'re designing Facebook\'s News Feed, focusing on how new posts instantly show up on people\'s feeds. What would you most likely use to make this work?',
    [
      'A Pub/Sub system.',
      'A blob store.',
      'A MapReduce job.',
      'A peer-to-peer network.',
    ],
    '''
[The Best Choice: Pub/Sub]
	= Imagine you're a superstar publisher who writes and draws awesome comic books. You have a bunch of fans who love your work.

	Instead of calling or texting each fan every time you finish a new comic book, you can use a special bulletin board. You simply pin your new comic book to the board, and everyone
	who wants to see it can look at the board and grab a copy.
	That's how a Pub/Sub system works!
	You, the superstar publisher, are the Publisher.
	The bulletin board is the system that delivers the messages.
	Your fans who check the bulletin board are the Subscribers.
	When someone posts on Facebook, they're the publisher, and their friends who follow them are the subscribers. The Pub/Sub system is like that special bulletin board—it makes sure
	the post gets to all the right friends super fast, so they can see it right away.

[Why Other Options Aren't as Good]
{A Blob Store}
	= Think of a blob store as a giant, super-organized closet. You can store all kinds of things in it, like your favorite toys, books, and even videos. This is where Facebook stores
	the pictures and videos you post. But the closet can't tell your friends you've added a new toy. It's only for storing things, not for telling people about them.

{A MapReduce Job}
	= A MapReduce job is like a huge team of librarians sorting through every book ever written to create a report about which books are the most popular. This takes a very, very long
	time. It's great for big jobs that don't need to be finished right away, like figuring out what everyone did last month. It's too slow to show you what's happening right now on your
	news feed.

{A Peer-to-Peer (P2P) Network}
	= A P2P network is like if you had to personally hand-deliver every comic book you make to each and every fan's house. It sounds cool, but it would be a huge mess! What if a fan
	isn't home? What if you have a million fans? You'd be running around all day and night. It's just too much work and gets very confusing and slow, especially with billions of people
	using Facebook.
''',
  ),
  QuizQuestion(
    'The following are the three primary entities in a SQL database:',
    [
      'Tables, rows, and columns.',
      'Shards, tables, and rows.',
      'Tables, rows, and indices.',
      'Clusters, shards, and tables.',
    ],
    '''
  tables, rows, and columns are the three main things that make a database work and keep all the information neat and tidy!. Shards, Indices, Clusters are like extra tools or helpers.
    ''',
  ),
  QuizQuestion(
    'The following statement is correct:',
    [
      'With symmetric encryption, the same key is used to both encrypt and decrypt data.',
      'With asymmetric encryption, the same key is used to both encrypt and decrypt data.',
      'With asymmetric encryption, the private key is used to encrypt data and the public key is used to decrypt it.',
      'With symmetric encryption, the public key is used to encrypt data and the private key is used to decrypt it.',
    ],
    '''
  = With symmetric encryption, the same single key is used for both encrypting and decrypting data.
  = Asymmetric encryption uses a pair of different keys, not the same key, for encryption and decryption, and the public key encrypts the data and the private key decrypts it.
  = Symmetric encryption uses only one key and does not involve the concepts of public and private keys, which belong to asymmetric encryption.
''',
  ),
  QuizQuestion(
    'What is a man-in-the-middle attack?',
    [
      'An attack where someone secretly listens to or changes messages between two people.',
      'An attack where someone takes over a database transaction while it\'s happening.',
      'An attack where someone breaks a private key to read secret messages while they are being sent.',
      'A type of DDoS attack where bad traffic is boosted and sent to the target.',
    ],
    '''
- A [man-in-the-middle] (MitM) attack is when an attacker secretly inserts themselves between two communicating parties to eavesdrop or alter their messages without either party knowing.

- [Taking over a database] is a different type of attack, often called a SQL injection or database attack, which specifically targets databases, not a real-time conversation between two people.

- [Breaking a private key] often describes an attack on cryptography itself, where the attacker's goal is to directly break the key, which is a different goal from the interception and relay of a MitM attack.

- A [DDoS] (Distributed Denial of Service) attack is an attempt to overwhelm a server with a flood of traffic to make it unavailable to legitimate users.
''',
  ),
  QuizQuestion(
    'You\'re designing a stock-trading platform where users need to get immediate stock-price updates as well as immediate feedback that their trades have been executed. You want the system to have especially low:',
    ['Latency.', 'Throughput.', 'Redundancy.', 'Downtime.'],
    '''
[Latency:]
	= Latency is the time delay between a user's action (like clicking "buy") and the system's response (like showing "trade executed"). For a stock trading platform, this needs to be
	as low as possible because every millisecond counts. A high latency could mean a user misses out on a good price or a trade is executed at a worse price than intended. It's all
	about speed and responsiveness.

[Why the Others Are Incorrect?]
	{Throughput:} This refers to the amount of work a system can handle in a given amount of time (e.g., trades per second). While a good trading platform needs high throughput, the most
	critical factor for immediate feedback is the time it takes for a single action to complete, which is latency. You can have high throughput but still have high latency if the system
	is batching requests.

	{Redundancy:} This is about having backup systems to prevent failure. While important for a trading platform to prevent losing money, it doesn't directly relate to the speed of
	feedback for a single action.

	{Downtime:} This is the total time the system is not working. It's crucial to minimize downtime, but the question is about the speed of a working system, not its availability. A
	system can have very low downtime but still have high latency.
''',
  ),
  QuizQuestion(
    'Which of these pairs doesn\'t quite fit with the others?',
    [
      'Polling | availability.',
      'Caching | latency.',
      'Replication | redundancy.',
      'Peer-to-peer network | throughput.',
    ],
    '''
The option ["Polling | availability"] is the correct answer because it's the only pair that doesn't fit the pattern. 
The other three pairs correctly link a technical concept to the problem it's designed to solve. 
  - [Caching] is used to reduce [latency] by storing data closer to the user. 
  - [Replication] increases [redundancy] by creating multiple copies of data, which in turn improves availability.
  - [Peer-to-peer networks] enhance [throughput] by allowing many devices to share the workload. 
However, polling, which is the act of a system repeatedly checking the status of another, is not a primary method for ensuring a system's availability; it's more about data synchronization or monitoring.
''',
  ),
  QuizQuestion(
    'When creating an API that lists things like comments or posts, what should the endpoint usually support?',
    [
      'Breaking results into pages (pagination).',
      'Hiding details (obfuscation).',
      'Checking who the user is (authentication).',
      'Removing items (deletion).',
    ],
    '''
[Pagination] is the only correct answer because it's a fundamental feature for any API that lists items like comments or posts. 
    = When a list can have thousands or millions of entries, trying to send all of them at once would be incredibly slow and inefficient for both the server and the user. 
      Pagination solves this by breaking the list into smaller, manageable "pages." 

-> While things like [authentication] and [deletion] are also important API functions, they are separate actions, not core features of the listing endpoint itself. 
-> [Hiding details (obfuscation)] is a security technique, not a standard function for this type of API endpoint.''',
  ),
  QuizQuestion(
    'Which of these is a common use for a peer-to-peer network?',
    [
      'Sending a big file to thousands of machines at once.',
      'Sending lots of random requests to thousands of machines at the same time.',
      'Quickly finding a broken machine among thousands of machines.',
      'Checking the identity of thousands of machines at the same time.',
    ],
    '''
A [peer-to-peer (P2P)] network is best for sharing big files with many people at once. 
Instead of one main computer trying to send the file to everyone, which would be very slow, a P2P network lets each person who gets a piece of the file also help share it with others. 
This makes the process much faster for everyone. The other choices are wrong because P2P networks aren't good for those jobs. 
They aren't built for a "random requests" attack, finding a broken computer, or checking who everyone is, because these tasks usually need a central, organized system.''',
  ),
  QuizQuestion(
    'Google Cloud Storage (GCS) and Amazon S3 are both storage solutions best used to store:',
    [
      'Large, unstructured data.',
      'Tabular-like, structured data.',
      'Time-series data.',
      'Encrypted data.',
    ],
    '''[Google Cloud Storage] and [Amazon S3] are both examples of object storage, a system built specifically to handle large, unstructured data. 
    Unlike traditional file storage that uses folders and hierarchies, object storage keeps data as individual "objects" in a flat structure, which makes it perfect for storing huge amounts of data like photos, videos, backups, and data for big data analytics. 
    The other options are incorrect because they refer to types of data that are not the primary purpose of these services: "tabular-like, structured data" is better suited for a database, "time-series data" is for specialized databases, and while GCS and S3 can store "encrypted data," that is a feature, not the type of data they are best used to store.''',
  ),
  QuizQuestion(
    'The following API endpoint makes the most sense to be rate-limited:',
    [
      'An endpoint to post a comment.',
      'An endpoint to delete an entity.',
      'An endpoint to log into a service.',
      'An endpoint to purchase a product.',
    ],
    '''
An endpoint to post a comment is the most likely correct answer because it's a primary target for abuse and spam. While a login endpoint is crucial for security against brute-force attacks, a public-facing API that allows users to post content is highly vulnerable to bots and spammers who can flood the system with unwanted content. Rate limiting this endpoint helps to:

      [Prevent spam:] A rate limit can stop a bot from automatically posting hundreds of comments in a short time.

      [Manage system load:] It protects the database and server from being overwhelmed by a sudden, massive influx of data.

      [Encourage legitimate use:] It ensures that a single user cannot monopolize the service, allowing for fair use by all.

In contrast, while the other options can also be rate-limited, they are less likely to be a high-volume target:

      [Login endpoint:] This is typically rate-limited to prevent brute-force attacks, but the volume of requests is generally lower than comment spam.

      [Delete an entity:] This is a more sensitive action, and a user is less likely to repeatedly delete items in a short period.

      [Purchase a product:] This is a financial transaction, and abuse is typically handled by other fraud detection systems rather than just simple rate limiting.

Therefore, from a system and content management perspective, rate-limiting the "post a comment" endpoint is a more common and necessary measure to protect against widespread abuse and maintain the quality of the service.

''',
  ),
  QuizQuestion(
    'Which best describes a typical TLS handshake?',
    [
      'Creating secret keys that both client and server use to encrypt and decrypt messages.',
      'Creating a public/private key pair used by the server to encrypt messages and the client to decrypt them.',
      'Sending several messages back and forth between client and server to set up a stable connection.',
      'Signing an SSL certificate to prove the server is trustworthy.',
    ],
    '''
A [TLS handshake] is the process where a client and server establish a secure connection by agreeing on and creating secret keys. 
These keys are then used by both parties to encrypt and decrypt all subsequent data exchanged during that session. This ensures that the communication is confidential and protected from eavesdropping. 
The other options are incorrect because they either describe only a part of the process or misrepresent the core function of the handshake, which is the secure exchange of session keys for encryption.
''',
  ),
  QuizQuestion(
    'Which of these is an example of horizontal scaling?',
    [
      'Using more machines to do a job and handle more work.',
      'Sending requests to different database servers based on a hash to use cache better.',
      'Adding more RAM to a computer to make it faster.',
      'Replacing a server regularly to avoid downtime.',
    ],
    '''
Using more machines to do a job is the correct answer because [horizontal scaling] involves adding more machines to a system to distribute the workload and handle more traffic. 
Instead of making a single machine more powerful (which would be vertical scaling), you add more computers to your network. 
This approach is highly flexible and cost-effective, allowing you to grow your system's capacity as demand increases. 
The other options describe different performance optimizations or maintenance tasks, not the core concept of adding more machines to scale a system.
''',
  ),
  QuizQuestion(
    'The following system is most likely to be highly available:',
    [
      'A messaging system used by air traffic controllers to communicate with pilots while they\'re in flight.',
      'A popular online video game.',
      'An internal tool at a company, allowing employees to check their available vacation days.',
      'An online dashboard for businesses to check their financials (sales, revenue, etc.).',
    ],
    '''
Think of [high availability] as a system that just doesn't quit. It's built to keep working no matter what.
An [air traffic control system] is a perfect example because if it fails, planes can't talk to the ground, which is extremely dangerous. Lives are on the line, so this system must always be on. 
They build it with backup plans upon backup plans, so if one part breaks, another part immediately takes over.
The other systems are important, but if they go down for a little while, it's not a life-or-death situation. It's a problem, but not a crisis. That's why the air traffic system is the best answer.''',
  ),
  QuizQuestion(
    'The following is an example of load balancing software:',
    ['NginX', 's3', 'Zookeeper', 'Redis'],
    '''
[Nginx] is the correct answer because it is a very common type of load balancer. A load balancer acts like a traffic cop, distributing incoming requests across multiple servers. 
This prevents any single server from being overwhelmed and helps a website or application stay fast and reliable.

The other options are not load balancers:

	- [S3] is a cloud storage service used for storing files, like photos and videos.

	- [Zookeeper] is used to manage and coordinate large distributed systems, not to direct traffic.

	- [Redis] is a type of database used for fast data storage and caching.''',
  ),
  QuizQuestion(
    'What is consistent hashing used for?',
    [
      'Reduce how many requests have to switch to different servers when servers are added or removed.',
      'Choose which servers should get requests when new ones are added or old ones are removed.',
      'Stop requests from being sent to different servers when the server list changes.',
      'Make sure as many requests as possible go to different servers when servers are added or removed.',
    ],
    '''
[Why is it correct?]
	= because {consistent hashing} is designed specifically to reduce the number of requests that need to be "re-homed" to a new server when the number of servers changes.

[Why other options are wrong?]
	={consistent hashing} is not about choosing which servers get requests in general; it's about making sure the same request goes to the same server while making changes to the servers easy.

	=You cannot stop requests from changing servers entirely when servers are added or removed; some changes are necessary. The goal is to make the number of changes as small as
	possible.

	={Consistent hashing} does the opposite: it tries to make sure as few requests as possible go to different servers when the server list changes.''',
  ),
];
