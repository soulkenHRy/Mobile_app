import './quiz_question.dart';

const questions4 = [
  QuizQuestion(
    'Which of these actions do the same thing even if you do them many times? (Check all that apply)',
    [
      'Making a Slack channel private.',
      'Marking an email as read.',
      'Changing a phone number in a bank account.',
      'Unsubscribing from an email list.',
    ],
    '''All of these actions are correct because they are idempotent, meaning they produce the same result regardless of how many times you perform them.

            [Making a Slack channel private:] If a channel is already private, trying to make it private again doesn't change its state. It remains private.

            [Marking an email as read:] Once an email is marked as read, marking it as read again does nothing. It stays marked as read.

            [Changing a phone number in a bank account:] If you change your number to a new one and then try to change it to that same new number again, the final number on file doesn't change.

            [Unsubscribing from an email list:] After you've unsubscribed, trying to unsubscribe again has no effect; you remain unsubscribed.
    ''',
  ),
  QuizQuestion(
    'You\'re designing a system. Which of these questions are good to ask before you start? (Check all that apply)',
    [
      'How fast does each part of the system need to be?',
      'How many users will use this system?',
      'Is this system for people around the world or just one region?',
      'How reliable does each part of the system need to be?',
    ],
    '''
1. [How fast does each part of the system need to be?]
    => This question is about latency. Knowing the speed requirements for different parts of the system helps you decide where to use high-speed memory (RAM) versus slower, persistent storage (hard drives).
      It also helps you understand where to add caches and how many servers you'll need to handle the workload.

2. [How many users will use this system?]
    => This question addresses scalability and load. The number of users directly impacts how much traffic your system will receive. A system with a million users needs a very different design than one with a hundred users.
    This helps you determine if you need to use a single server or a distributed system with multiple servers and load balancing.

3. [Is this system for people around the world or just one region?]
    => This question is about distribution and global reach. A global system must handle latency caused by long distances and might require a Content Delivery Network (CDN) or geographically distributed servers.
    A system for a single region can be much simpler and doesn't need to worry about serving clients from the other side of the world.

4. [How reliable does each part of the system need to be?]
    => This question is about availability and fault tolerance. Asking this helps you decide if you need to build redundancy into your system.
    For example, a system for managing life-critical hospital data needs to be highly reliable and available, likely requiring database replication and backups. A personal blog might not need such high-level reliability.''',
  ),
  QuizQuestion(
    'Which of the following statements are true? (Check all that apply)',
    [
      'HTTP is a network protocol that runs on top of TCP.',
      'Most computers today talk to each other using IP.',
      'HTTP is easier for humans to read and use compared to lower-level protocols like TCP and IP.',
      'TCP is a network protocol that runs on top of IP.',
    ],
    '''
Correct Options
    [HTTP is a network protocol that runs on top of TCP:] HTTP is a high-level protocol for web data, and it relies on the TCP protocol to reliably send and receive that data.

    [Most computers today talk to each other using IP:] The Internet Protocol (IP) is a core standard that gives every device an address and is responsible for getting data from one computer to another.

    [HTTP is easier for humans to read and use compared to lower-level protocols like TCP and IP:] HTTP messages are sent as plain text, while TCP and IP data are sent as machine-readable binary code.

    [TCP is a network protocol that runs on top of IP:] TCP handles reliable data delivery and error checking, and it uses IP to get its data packets from a source to their destination.
    ''',
  ),
  QuizQuestion(
    'The following are legitimate use cases of proxies (check all that apply):',
    [
      'Logging client information.',
      'Load balancing requests across servers.',
      'Caching server responses.',
      'Masking a client\'s identity.',
    ],
    '''
All of the options are correct because they are all common and legitimate uses of a proxy server. A proxy acts as an intermediary, handling requests and responses between a client and a server, which allows it to perform a variety of tasks.

    [Logging client information:] A proxy can easily record details about requests, like who is asking for data and when, which is useful for security and monitoring.

    [Load balancing requests across servers:] A proxy can intelligently distribute incoming requests to multiple servers, which prevents any one server from getting overloaded.

    [Caching server responses:] A proxy can store frequently requested data and serve it directly, which makes websites load faster and reduces the burden on the main server.

    [Masking a client's identity:] A proxy can hide a user's IP address and location from the websites they visit, which provides privacy and can help bypass restrictions.
    ''',
  ),
];
