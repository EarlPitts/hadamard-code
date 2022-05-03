- Simulate the channel
- Send some ascii message
- Send the picture of Mars

# Code

- Encoding:
    - Generator matrix:
        - All permutations of m bits (m is the message length)
    - Multiply the message with the generator matrix
- Decoding:
    - Get the syndrome
    - Use the syndrome to get the row of the Hadamard matrix (this is the error-corrected encoded message)
    - Get the original message by the "unencoding matrix":
        - Information set of the codeword * antidiagonal matrix

# TODO

- https://www.youtube.com/watch?v=Koc3UxeC838&t=125s

- Error-correcting code
- Linear code
- Binary alphabet
- Based on **Hadamard matrices**

# Coding

1. Source Encoder -> Encryption -> Channel Encode -> Modulator
2. Channel
3. Demodulator -> Channel Decode -> Decryption -> Source Decoder -> Digital Link

## Basics

- **Coding parameters** (measuring the "goodness" of codes):
    - Code length
    - Number of codewords
    - Distance
- **Hamming weight**: nonzero components in the codeword
- **Hamming distance**:
    - Number of places where two codewords differ
    - $d(x,y)$ is the Hamming weight of the vector $x - y$
- **Minimum Hamming distance**: the minimum distance between any two codewords
- **Code** $(n,M,d)$:
    - $n$: Code length
    - $M$: Total number of codewords
    - $d$: Minimum distance
- We want:
    - Small n (fast transmission)
    - Large M (wide variety of messages)
    - Large d (detect many error)
- **Rate**:
    - Ratio $n/k$ of message symbols to coded symbols
    - Higher rate codes are more efficient, transfer messages faster
- **Nearest neighbor decoding**:
    - Finds the codeword that minimizes the distance between the received vector and possible transmitted vectors
- A code with minimum distance d can:
    - Detect up to $d-1$ errors
    - Correct up to $|__(d-1)/2__|$ errors
- **Perfect code**: The *sphere-packing* problem is satisfied with equality

## Linear Codes

- Special codes with rich mathematical structure
- Widely used in practice:
    - Easy to construct
    - Encoding is quick and easy
- **Linear codes are vector subspaces of vector spaces**:
    - A linear code of length $n$ over $GF(q)$ is a subspace of $GF(q)^n = V(n,q)$
- **Generator matrix**:
    - A $k x n$ matrix, whose rows form a basis for an $[n,k]$ linear code:
        - As they form a basis, the rows of the generator matrix have to be independent
    - A compact way to descibe all codewords in a code
    - A way to encode messages
    - *It's rows form a basis for a linear code*
    - Used by performing the multiplication $mG$
    - The encoding function $m -> mG$ maps the vector space $V(k,q)$ onto a k-dimensional subspace (the code C) of the vector space of $V(n,q)$

### Binary Linear Codes

- $C$ with length $n$ is a set of binary n-tuples, such that the componentwise module 2 sum of any two codewords is in $C$:
    - If you add up two codewords, the result is an other codeword
- **Minimum distance** $d(C)$ is always equal to $w^*(C)$, the weight of the lowest-weight nonzero codeword
- **Extended code**: We can increase the minimum distance by apending an *overall parity check digit* to each codeword

# Abstract Algebra

## Fields

- $(F,+,*)$:
    - F: nonempty set
    - There is an additive identity element
    - There is an additive inverse element
    - There is a multiplicative identity element
    - There is a multiplicative inverse element
    - +: commutative, associative binary operation
    - *: commutative, associative binary operation
    - + and * distribute
- The binary alphabet with module 2 addition and multiplication is the *smallest field*
- **Galois Field**:
    - Fields with a finite alphabet (finite fields)
    - $GF(2)$ is the Galois Field with the binary alphabet

# Hadamard Matrix

- $H_n with elements 1 or -1 (or any binary elements) such that H_nH^t_n = nI_n$
- Each row "agrees" with all other rows in $n/2$ positions
- $n$ is the order (n x n matrix)
- The size can be 2 or any multiple of 4
- **Sylvester construction**: 
    - Constructing Hadamard matrices from existing ones
    - Putting the original matrix into the *top left*, *top right* and *bottom left* corners, and the inverse (flip the signs) into the *bottom right*
    - *This construct is also called the Kronecker product*
