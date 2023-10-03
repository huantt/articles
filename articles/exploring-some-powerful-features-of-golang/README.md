
## Table of content

1. [Goroutines](#goroutines)
2. [Channel] (#channel)
3. [Buffered Channel](#buffered-channel)
4. [Defer](#defer)
5. [Select](#select)
6. [Plugin] (#plugin)
7. [Binary Output] (#binary-output)
8. [Cross-Platform Support] (#crossplatform-support)

## Goroutines
Goroutines are lightweight threads managed by the Go runtime rather than directly by the OS. This makes them far less resource-intensive than traditional threads, allowing you to start thousands or even millions of goroutines in the same program without exhausting system resources.

This is an example of how to create a goroutine:

```golang
package main

import (
	"fmt"
	"time"
)

func say(s string) {
	for i := 0; i < 5; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Print(s)
	}
}

func main() {
	go say("world")
	say("hello")
}
// Output: hello world
```
## Channel
Channels in GoLang are a powerful feature that enable safe and effective communication between different goroutines. They help to implement pub-sub patterns as an alternative to callbacks across multiple threads. Channels also make sharing data between goroutines safe and easy, ensure data is synchronously exchanged, which prevents common issues like race conditions.

```golang
package main

import (
	"fmt"
	"time"
)

func producer(ch chan int) {
	for i := 0; ; i++ {
		ch <- i // Send a number i to channel ch.
		time.Sleep(time.Duration(1)*time.Second)
	}
}

func consumer(ch chan int) {
	for {
		msg := <-ch // Receive a number from channel ch.
		fmt.Println(msg)
	}
}

func main() {
	ch := make(chan int)

	// Start producer goroutine
	go producer(ch) 

	// Start consumer goroutine
	go consumer(ch) 

	// Run for a while to see the results
	time.Sleep(time.Duration(10)*time.Second)
}

```

## Buffered channel
Buffered channels are a type of channel with a specified capacity, allowing them to hold multiple values in the channel buffer, even if there aren't corresponding receives ready for these values. The capacity determines how many values the channel can hold without blocking sends, until the buffer is full.
```golang
package main

import "fmt"

func main() {
    // Create a buffered channel with a capacity of 2.
    ch := make(chan int, 2)

    // Send values into the channel buffer.
    ch <- 1
    ch <- 2

    // Because our channel is buffered, these sends do not block.

    // Receive values from the channel.
    fmt.Println(<-ch) // Outputs: 1
    fmt.Println(<-ch) // Outputs: 2
}
```

## Defer
The defer statement in Go allows you to schedule a function call to be executed after the completion of the function in which the defer statement is present. This becomes extremely useful when we want to ensure that clean-up tasks are performed before exiting a function (such as closing file, channel,...), even if an error occurs during the execution.

Example:

```golang
package main

import "fmt"

func main() {
	defer fmt.Print("world")
	fmt.Println("hello")
}
// Output: hello world

```
**Note:**
In GoLang, the arguments of a function to be deferred are evaluated at the time the defer statement is encountered, not when the function actually gets executed at the end of the enclosing function. This can lead to non-intuitive results, especially when variables are mutated after the defer statement.

For instance, consider the following code:
```golang
package main

import (
	"fmt"
)

func main() {
	a := 1
	defer fmt.Println(a) // a is evaluated here, so this will print 1
	a++
	fmt.Println(a) // This will print 2
}
```


## Select
The `select` statement in Go allows a goroutine to wait on multiple channel operations until one of its case statements completes, providing a way to handle multiple channels within 
 a single construct.


```golang
package main
import (
	"fmt"
	"time"
)

func main() {
	c1 := make(chan string)
	c2 := make(chan string)

	go func() {
		time.Sleep(1 * time.Second)
		c1 <- "message 1"
	}()
	go func() {
		time.Sleep(2 * time.Second)
		c2 <- "message 2"
	}()

	for i := 0; i < 2; i++ {
		select {
		case msg1 := <-c1:
			fmt.Println("received", msg1)
		case msg2 := <-c2:
			fmt.Println("received", msg2)
		}
	}
}

```
This example uses `select` to wait on both channels and print whichever one receives a message first.

## Plugin
GoLang supports the creation of plugins – modules that can be loaded and used at runtime. This provides flexibility in application architecture, enabling you to build modular and extendable applications.
Read more about plugin [here](https://dev.to/jacktt/plugin-in-golang-4m67).

## Binary Output
GoLang has the ability to compile source code into binary executables. These standalone executables can be run on different platforms without any external dependencies or virtual machine.

## Cross-Platform Support
Go is a platform-independent language. It can be compiled and executed on various platforms, including Windows, Linux, and macOS. It provides standard libraries to work with different operating systems, enhancing its cross-platform functionality. This feature is essential for building robust and portable applications in today's multi-platform world.