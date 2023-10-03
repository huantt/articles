If I get a JWT and can decode the payload, how is it secure? Why couldn't I just grab the token out of the header, decode and change the user information in the payload, and then encode it again to access any person's account? - My friend asked me this question today.

The short answer is NO, you can decode to see payload but can not edit payload!
Let's see how it works!

## How does JWT work?
JWT consists of 3 parts: Header, Payload, and Signature.
```javascript
const token = base64urlEncoding(header) + '.' + base64urlEncoding(payload) + '.' + base64urlEncoding(signature)
```

It will look like that:
```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c
```

**Header**
The header identifies which algorithm is used to generate the signature.

For example, decoded header of the above JWT will look like:
```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```
It indicates that this JWT uses HS256 (HMAC with SHA-256) algorithm to generate the signature.

**Payload**
Contains a set of claims. The JWT specification defines seven Registered Claim Names which are the standard fields commonly included in tokens such as exp(Expiration Time), iat(Issued at),…
Custom claims are usually also included, depending on the purpose of the token such as email, user_id, role,…

The above JWT's Payload is:
```json
{
  "sub": "1234567890",
  "name": "John Doe",
  "iat": 1516239022
}
```

**Signature**
Securely validates the token. The signature is calculated by encoding the header and payload using Base64url Encoding RFC 4648 and concatenating the two together with a period separator. That string is then run through the cryptographic algorithm specified in the header, in this case, it's HMAC-SHA256. The Base64url Encoding is similar to base64, but uses different non-alphanumeric characters and omits padding.


## Answer the questions

### Can anyone decode to see the payload?
Yes, they can! 3 parts of the token are basically Base64url encoding, so everyone can decode easily. You can try it at [jwt.io](https://jwt.io).

![Image description](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/x17d5tbyvvzu518jww6u.png)


### Can anyone edit the payload?
Sure, everyone can decode to get the JSON payload, edit it then encode it to get a new token with edited payload value.

But this token is not valid anymore, because the signature is invalid.

Scroll up to read "<u>how the signature is generated</u>" again. 
"_It's calculated by encoding the header and payload using…_". So when you edit the payload and then send the token to server, server will calculate the signature, compare and know that your signature is invalid!

So why don't I generate the corresponding signature? 
No, you can not! Read "_how the signature is generated_" again: "_That string is then run through the cryptographic algorithm specified in the header_".
In this case, the header indicates that its signature is encrypted using HMAC-SHA256, so if you want to generate the signature, you must have the HMAC-SHA256 **secret key** - that was used to generate this signature before.

### Can anyone validate it's a valid JWT from a server?
It depends on the algorithm used in the JWT.
The most common algorithm used to sign the JWT is as follows:
- **HMAC** stands for Hash-based Message Authentication Code, and it is a symmetric algorithm that uses a hash function and a secret key to generate a signature.
- **RSA** stands for Rivest-Shamir-Adleman, and it is an asymmetric algorithm that uses a public and private key pair to generate and verify a signature.

So:
- With HMAC, only users who hold the secret key can validate the JWT.
- With RSA, anyone can validate the JWT using the public key that is published somewhere.