## What is limit-order feature?

Imagine you’re trading Token A at a price of $0.1, and your target is $1. Typically, you would need to set a price alert on a platform such as Coinmarketcap or Dexscreen and manually take profit when the price reaches your target. However, what if the price hits your target while you’re sleeping? You may miss this trade. This is why the limit-order feature was created.

The limit-order feature allows traders to set a price threshold for executing trades “automatically” when the specified price is reached.

You can use DEXs such as 1inch and PancakeSwap to execute limit orders, but the implementation of the feature differs between the two platforms. Let’s take a look at how they differ.

## Limit-order on Pancakeswap

Limit-order feature on PancakeSwap
When you place a limit-order on PancakeSwap, your tokens will be sent to PancakeSwap contract. Of course you need to pay gas fee for each limit-order request.

Who will execute your order?
PancakeSwap’s backend system will keep checking the price and execute your order when the price reaches your target. In this model, your order is executed similarly to how you swap on PancakeSwap via a liquidity pool, which means that your order can impact the market price.

## Limit-order on 1inch

Limit-order feature on 1inch
When placing a limit order on 1inch, you simply need to sign a message, and your tokens will remain in your wallet until the order is executed. This means that you do not need to pay any gas fees for your orders.

Who will execute your order?
When you place a limit order on 1inch, your order is sent to the 1inch backend. All orders are public and can be accessed by anyone through a public API. These individuals, also known as ‘fulfillers,’ can call 1inch’s API to retrieve pending orders and identify orders that match their criteria, such as a profitable price or specific token. They can then execute the orders by calling the ‘fulfillOrder’ function in 1inch’s smart contract.

In this model, 1inch serves as a platform that connects two-sided markets, namely buyers and sellers. This model is similar to over-the-counter (OTC) trading, which means that all executions do not impact market prices because assets are transferred directly instead of being swapped via liquidity pools.

## Conclusion

On some DEXs, you can place limit orders similarly to how you would on CEXs such as Binance, Gate.io, Huobi, and others.

Utilizing decentralized exchanges such as 1inch and PancakeSwap enables traders to execute limit orders, although the feature’s implementation differs between these platforms:

With PancakeSwap, tokens are sent to the platform’s contract, and gas fees are required for each limit order request, while 1inch allows users to sign a message and keep tokens in their wallet until the order is fulfilled, without incurring any gas fees.
On 1inch, orders are executed by “fulfiller” while on PancakeSwap, they’re executed by PancakeSwap’s backend.