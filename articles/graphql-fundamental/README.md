GraphQL provides a complete and understandable description of the API, including both "API endpoints" and response data schema.

It empowers clients to request exactly what they need, ensuring that the server returns only the requested fields instead of a fixed response schema in RESTful API.

To do that, GraphQL declares a schema that includes types, queries, mutations,...

## Schema
A schema will look like this
```graphql
type Author {
    id: ID
    name: String
    books: [Book!]
}

type Book {
    id: ID
    author: [Author!]
}

type Query {
    getBooks: [Book!]
    getBook(id: ID): Book
}

type Mutation {
  addBook(name: String, author_id: String): Book
}
```

## Client request
Graphql uses POST method to communicate between client and server.

A request body looks like this

```json
{
  "query": "query whatever_name {\n  getBooks {\n    name\n  }\n  \n  getBook(1) {\n    name\n  }\n}",
  "variables": {}
}
```

Output will look like
```json
{
  "data": {
    "getBooks": [
      {
        "name": "Hello world"
      }
    ],
    "getBook": {
      "name": "Hello 1"
    }
  }
}
```

### Query
Let's zoom in on to the `query` field:

```graphql
query whatever_name {
  getBooks {
    name
  }
  
  getBook(1) {
    name
  }
}
```

A request can call more than one query. To make it easier to imagine, with GraphQL, you can call multiple RESTful APIs in one request. As you can see, the response will consist of corresponding responses in a key-value format, with the key being the query name and the value being the response data.

## Variable
For reusability, a query can declare dynamic arguments and then inject the values by declaring variables in the request body.

Let's rewrite the query above appling dynamic arguments:
```graphql
query whatever_name($id: String) {
  getBooks {
    name
  }
  
  getBook($id) {
    name
  }
}
```


Request body:
```json
{
  "query": "query whatever_name($id: String) {\n  getBooks {\n    name\n  }\n  \n  getBook($id) {\n    name\n  }\n},
  "variables": { "id": 1 }
}
```

### Explore a Graphql Endpoint
You can request the following query to receive types of any Graphql. 

_(I extracted it from Postman)_

https://gist.github.com/huantt/3d8db80c878082e1237ab531a8e7ee26