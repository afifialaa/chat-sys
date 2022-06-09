# Instabug Backend Challenge

This repository is a REST api for a chat system. Built with Ruby/Rails and MySQL as main database.
* Ruby 3.0.0
* Rails 6.1.6
* MySQL 8.0
* Elasticsearch 8.2.2
* Redis 6.2

### **Please check the wiki for more information and code specs.**

## Installation

1. Clone the repository
```bash
git clone https://github.com/afifialaa/chat-sys
```
2. change directory to chat-sys
```bash
cd chat-sys
```
4. Build an image.
```bash
docker-compose build
```
3. Start the containers
```bash
docker-compose up
```
And now the app is running on http://localhost:3001

## Api Version 1 usage

all routes are preceeded with /api/v1

### Application routes

| Method        | URL                  | description            |
| ------------- | -------------        |-------------           |
| POST          | /application  |creates new application  |
| GET           | /application/:token  |returns an application|
| DELETE        | /application/:token  |deletes an application|
| PUT           | /application/:token  |updates an application|

### Chat routes

| Method        | URL                  | description            |
| ------------- | -------------        |-------------           |
| POST          | /application/:token/chat  |creates new chat  |
| GET           | /application/:token/chats  |returns chats in application|
| DELETE        | /application/:token/chat/:chat_number |deletes a chat|
| GET        | /application/:token/chat/:chat_number |returns chat|

### Message routes

| Method        | URL                  | description            |
| ------------- | -------------        |-------------           |
| POST          | /application/:token/chat/:chat_number/message  |creates a new message  |
| DELETE           | /application/:token/chat/:chat_number/message/:number  |deletes a message|
| PUT           | /application/:token/chat/:chat_number/message/:number  |updates a message|
| GET           | /application/:token/chat/:chat_number/message/:number  |returns a message|
| GET           | /application/:token/chat/:chat_number/messages |returns messages in a chat|
| GET           | /application/:token/chat/:chat_number/message/:search/:query  |return matching messages|

### **Please check the wiki for more information and code specs.**

## Pending
* Queuing jobs
* Database seeders
* Testing
