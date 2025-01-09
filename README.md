# ChatDev-iOS

This repository contains a Swift project for creating a simple social feed app, where users can interact with posts in a seamless and engaging manner. The app features a UICollectionView that displays posts in a scrollable format, with two primary sections: one dedicated to creating new posts and the other for viewing existing posts. Each post includes a message, a list of users who liked the post, and a timestamp indicating when it was made.

Key Features:

- **Create Post Section**: The first section of the collection view allows users to create new posts. This section includes a cell with a simple interface to input the post's content. While this part is designed to collect post data, it can be expanded to include more features, such as image or media attachments, in future versions.

- **Post Feed Section**: The second section displays a feed of posts fetched from the backend. Posts are shown with the post message, the number of likes, and the timestamp. This section allows users to scroll through various posts in a vertical list.

- **Pull-to-Refresh**: The app integrates a pull-to-refresh functionality using UIRefreshControl to fetch the latest posts from the server. When a user pulls down on the feed, it triggers an API call to update the posts dynamically, providing an up-to-date social experience.

- **Backend Integration**: The app fetches post data from a server using the NetworkManager class, which handles API requests. The fetched data is then displayed in the collection view in real-time. This setup can be extended to include additional features like commenting or media support.

- **Simple and Flexible Layout**: Using UICollectionViewFlowLayout, the app provides a clean and flexible layout with customizable cell sizes and padding. The layout can easily be adapted to support different screen sizes and orientations, making the app responsive on various devices.

- **Extensibility**: The project is designed with extensibility in mind. The data model, views, and layout are modular and can be easily extended to include additional features, such as user profiles, notifications, or real-time updates.

### Requirements

You must have Swift 5, iOS 13.0+, and Xcode 12.0+ to run this app.

### Architecture:

- **FeedVC**: The main view controller manages the social feed. It handles the fetching of posts, setting up the collection view, and refreshing the feed when new data is available.

Figma: https://www.figma.com/design/L2BUmqxxmh7jjuPCx9hBuX/ChatDev-iOS?node-id=0-1&p=f&t=UUjTGKX75H7X4hXS-0

- **NetworkManager**: A singleton responsible for fetching posts from a server. It abstracts the network layer and provides the app with fresh data each time the feed is refreshed.

- **Collection View**: The app uses a UICollectionView to display posts in a list format. It supports vertical scrolling and customizable cell layouts for both the create post and feed sections.
