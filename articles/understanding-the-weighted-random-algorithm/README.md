Imagine you have a collection of items, and each item has a different "weight," or probability of being chosen. The weighted random algorithm is a method for selecting items from this collection according to their weights, essentially giving items with higher weights a greater chance of being chosen. In this article, I will explore how this algorithm works.

## Application
The Weighted Random Algorithm can be applied in computing and data processing. Here's a list of some common use cases:
- **Randomized Selection**: Use this algorithm for selecting items with different probabilities, such as selecting ads to display in online advertising, where ads with different click-through rates are weighted differently.

- **Game Development**: In gaming, you can apply this algorithm to create random events or assign probabilities to different outcomes, like character/item drops or enemy behavior.

- **Load Balancing**: When distributing requests across multiple servers in a load-balancing scenario, you can use weighted random selection to allocate more or fewer requests to different servers based on their capacity or performance

- **Recommendation Systems**: Weighted random algorithms are used in recommendation engines to prioritize and present content based on user preferences and content relevance.
The higher the relevance score of a variant, the more it will be displayed to the user.



## The concept
To understand the weighted random algorithm, let's imagine it as a space where each area represents the weight of an element. This space is analogous to a line, and the length of each segment on this line corresponds to the weight of an element. If you throw a stone into this space, the probability of the stone landing in a specific area is directly proportional to the weight of that segment, regardless of the order of areas.

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/gb6evmessrk9xxvx27c7.png)

## Implementation of Weighted Random Algorithm
```typescript
function randomByWeight(values: string[], weights: number[]): string {
  let total = 0

  // Sum total of weights
  weights.forEach(weight => {
    total += weight
  })

  // Random a number between [1, total]
  const random = Math.ceil(Math.random() * total) // [1,total]

  // Seek cursor to find which area the random is in
  let cursor = 0
  for (let i = 0; i < weights.length; i++) {
    cursor += weights[i]
    if (cursor >= random) {
      return values[i]
    }
  }
  return "never go here"
}

```

## Explain the algorithm
**1. Calculate the Total Weight**

The first step in the weighted random algorithm is to determine the total weight. This is done by summing up the weights of all the elements in the collection. In our example, the total weight would be 20 + 30 + 50 = 100.

```typescript
let total = 0

weights.forEach(weight => {
  total += weight
})
```

**2. Generate a Random Number**

Next, we generate a random number within the range of 1 to the total weight `([1,total])`. This random number is our "cursor," and it determines where the stone will land in our space.

```typescript
const random = Math.ceil(Math.random() * total) // [1,total]

```

**3. Walk Through the Space**

We then walk through the space, moving the cursor from left to right by incrementing it by the weight of each element. The idea is to stop when the cursor exceeds or equals the random number generated earlier.

```typescript
let cursor = 0
for (let i = 0; i < weights.length; i++) {
    cursor += weights[i]
    if (cursor >= random) {
      return values[i]
    }
}
```

## Simple Explanation
The `Weighted random algorithm` can be likened to a `space` where each `area` corresponds to the `weight of an element`.

The implementation of this algorithm involves selecting a random point within this space and determining the specific area in which this point falls.