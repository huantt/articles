## Field declaration
By default, it's valid for any field in your schema to return null instead of its specified type.

You can require that a particular field doesn't return null with an exclamation mark !, like so:

```graphql
type Author {
  name: String! # Can't return null
  books: [Book!] # This list can be null but its list items can't be null
  articles: [Article!]! This list can't be null AND its list items can't be null
}
```

These fields are non-nullable. If your server attempts to return null for a non-nullable field, an error is thrown.

This is a cheatsheet:

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/qw92dttpwht7he248glp.png)

## Supported types
- Scalar (Data types)
- Object
- This includes the three special root operation types: Query, Mutation, and Subscription.
- Input
- Enum
- Union

### Scalar types
Scalar types are similar to primitive types in your favorite programming language. They always resolve to concrete data.

GraphQL's default scalar types are:

- Int: A signed 32‐bit integer
- Float: A signed double-precision floating-point value
- String: A UTF‐8 character sequence
- Boolean: true or false
- ID (serialized as a String): A unique identifier that's often used to refetch an object or as the key for a cache. Although it's serialized as a String, an ID is not intended to be human‐readable.


### Custom Scalar type
To define a custom scalar, add it to your schema like so:

```graphql
scalar YesNo
```

You can now use this scalar as a type for your fields.

```graphql
type Student {
  active: YesNo
}
```

However, it's only declared in GraphQL. To fully declare a custom scalar, you need to define ho Server interacts with it.

For instance, if you're using [99designs/gqlgen](https://github.com/99designs/gqlgen), you must follow this [docs](https://gqlgen.com/reference/scalars/#custom-scalars-with-user-defined-types). In summary, you will need to define a Go type, implement the `grqphql.Marshaler` and `graphql.UnMarshaler` interfaces, and declare this type in `gqlgen.yml`.

(If you're using Apollo Graphql, you can follow this [docs](https://www.apollographql.com/docs/apollo-server/schema/custom-scalars#example-the-date-scalar))

### Object type
An object type contains a collection of fields, each of which has its own type.

For instnace, in the following declaration, Author is an Object type.

```graphql
type Book {
  title: String
  author: Author
}
```

Every object type in your schema automatically has a field named `__typename` (you don't need to define it).
The `__typename` field returns the object type's name as a String (e.g., Book or Author). Clients can access this field the same way as they access other fields.

```graphql
query Book {
 title
 author {
  __typename
  name
 }
}
```

### Query type
The Query type is a special object type that defines all of the top-level entry points for queries that clients can request. It corresponds to API endpoints in RESTFul API.

```graphql
type Query {
  books: [Book]
  book(id: ID): Book
}
```

This Query corresponds to the following APIs in RESTFul API:
- /books
- /books/:id

Read more about how client call queries [here](https://dev.to/jacktt/graphql-fundamental-236k#variable).

### Mutation type

Mutation type defines entry points for write operations.

```graphql
type Mutation {
  addBook(name: String, author_id: String): Book
}
```

### Input type
If a query/mutation requires multiple arguments, you should create an Input type.

For example:
```graphql
input EditBookRequest {
    book_id: ID!
    new_name: String!
}

type Mutation {
    renameBook(input: EditBookRequest): Book
}
```

Request:
```graphql
mutation updateSomething($editBookRequest: EditBookRequest) {
    renameBook($editBookRequest) {
        name
    }   
}
```

Values:

```json
{
  "editBookRequest": {
    "book_id": 1,
    "new_name": "2"
  }
}
```

- Input types can’t have fields that are other objects, only basic scalar types, list types, and other input types.
- Start with `input` keyword instead of `type` keyword.

### Enum

Enum type define the allowed values for a type

```graphql
enum AllowedColor {
  RED
  GREEN
  BLUE
}
```

```graphql
type Query {
 changeColor(color: AllowedColor): Boolean
}
```

It restricts the input color to be within AllowedColor values.

### Union type
Union types help us define a new type from a set of Types. An instance of this type may be one of the union's types.

For example:

```graphql
union Media = Book | Movie

type Query {
  allMedia: [Media]
}
```

The output of the `allMedia` function may contain both book and movie records.

### Interface type
An interface specifies a set of fields. If an object type implements an interface, it must include all of that interface's fields.



### Subscription type
```graphql
subscription PostFeed {
  postCreated {
    author
    comment
  }
}
```

Read more detail [here](https://www.apollographql.com/docs/apollo-server/data/subscriptions).


## Reference
- https://www.apollographql.com/docs/apollo-server/schema/schema#the-schema-definition-language