This is a short code that demo how to implement rate limit in Golang.

```go
package main

import (
	"fmt"
	"sync"
	"time"
)

var limit = 10

var rate = time.Tick(time.Second / time.Duration(limit))

func main() {
	totalRequests := 100
	var wg sync.WaitGroup
	wg.Add(totalRequests)

	// Rate limit to 10 requests per second
	for i := 0; i < totalRequests; i++ {
		go func(i int) {
			defer wg.Done()
			sendRequest(i + 1)
		}(i)
	}

	// Wait until all request are completed
	wg.Wait()
}

func sendRequest(i int) {
	<-rate // Wait for the next tick
	fmt.Printf("Completed request %d at %d\n", i, time.Now().Unix())
}

```

In the above code, The `rate` variable is a channel of type `time.Time` that ticks at the desired rate. It is calculated by dividing the duration of a second by the limit. 

The `rate` channel will be locked until the ticker is reached, which means that each goroutine invoking `<-rate` will be blocked until the next tick occurs. This ensures that the requests are spaced out evenly and adhere to the desired rate of 10 requests per second.


If the goal is to perform many requests concurrently while maintaining a specific rate limit, you can consider the solution that's provided by @davidkroell :

```go
package main

import (
    "fmt"
    "sync"
    "time"
)

var limit = 10

var bucket = make(chan struct{}, limit)
var startTime = time.Now()

func main() {
    totalRequests := 100
    var wg sync.WaitGroup
    wg.Add(totalRequests)

    go func() {
        for {
            // the bucket refill routine
            for i := 0; i < limit; i++ {
                bucket <- struct{}{}
            }
            time.Sleep(time.Second)
        }
    }()

    // Rate limit to 10 requests per second
    for i := 0; i < totalRequests; i++ {
        go func(i int) {
            defer wg.Done()
            sendRequest(i + 1)
        }(i)
    }

    // Wait until all request are completed
    wg.Wait()
}

func sendRequest(i int) {
    <-bucket // get "token" from the bucket
    fmt.Printf("Completed request %3d at %s\n", i, time.Since(startTime))
}
``` 
