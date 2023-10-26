We are developing a crypto news aggregator [Bitesapp.co](https://bitesapp.co?utm_source=dev). A few days ago, we implemented A/B testing tool to test different scenarios for delivering news to users.

In this article, I will explain the A/B testing algorithm in the simplest possible way.

## Main concepts
**Inputs**
- User attributes (such as user_id, email, device_id,...)
- Experiments
- Weight for each experiment

**Requirements**
- The experiment variant must always be the same with a set of input attributes
- The user's probability of participating in the experiment is relative to the weight of the experiments (the higher the weight, the more users will be assigned to this experiment).


## Idea
This algorithm shares some similarities with the Weighted Random algorithm I explained in the previous article ([Link](https://dev.to/jacktt/understanding-the-weighted-random-algorithm-581p)).

To better understand this algorithm, let's imagine it as a space where each region represents the weight of an element. This space is analogous to a line, and the length of each segment on this line corresponds to the weight of an Experiment. If you throw a stone into this space, the probability of the stone landing in a specific area is directly proportional to the weight of that segment, regardless of the order of areas

In the `Weighted Random algorithm`, we likened the process to randomly throwing the stone. However, in the A/B testing algorithm, we need to find a way to consistently land in the same area for the same user with specific attributes.

## Implemenation
We will implement the above idea by the following steps:
- Scale the weights to a specific range, corresponding to fitting the areas into a specific space. The sum of the output weights will be equal to the maxScale.
- Hash the input attributes to a number between 1 and maxScale.
- Determine the area which this hashing value belongs.

#### 1/ Scale the weights to a specific range
```go
// golang
func scaleWeights(weights []float32, maxScale int) []float32 {
	var total float32 = 0.0
	for _, weight := range weights {
		total += weight
	}
	for i, weight := range weights {
		weights[i] = weight / total * float32(maxScale)
	}
	return weights
}
```

#### 2/ Hash the input attributes to a number between 1 and maxScale

```go
func hash(userID string, maxScale int) (int, error) {
	h := fnv.New32a()
	if _, err := h.Write([]byte(userID)); err != nil {
		return 0, err
	}
	hashValue := int(h.Sum32())
	return hashValue % maxScale + 1 , nil
}
```
To return the value between 1 and maxScale, we take a modulus for maxScale.

This is why we scale the weights into maxScale.

### 3/ Determine the area which this hashing value belongs

```go 
func getExperimentIndex(weights []float32, maxScale int, hashValue int) int {
	weights = scaleWeights(weights, maxScale)
	var cursor float32 = 0
	for i, weight := range weights {
		cursor += weight
		if cursor >= float32(hashValue) {
			return i
		}
	}
	return -1
}
```