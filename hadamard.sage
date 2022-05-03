from itertools import product

### Helpers for demo

def ascii_to_bin(c):
    return vector(GF(2), map(int, format(ord(c), "08b")))

def bin_to_ascii(b):
    """
    Convert b to an ascii char
    b is represented as a vector of bits
    """
    return chr(int("".join(list(map(str, b))), 2))

def encode_text(text):
    """
    Encodes a given ascii text message
    The returned vector contains each character as an
    encoded vector of bits
    """
    return map(encode, map(ascii_to_bin, text))

def decode_text(c_msg):
    """
    Decodes the given coded message, and returns the original text
    """
    return "".join(map(bin_to_ascii, map(decode, c_msg)))

### Hadamard Code implementation

def hadamard(size):
    """Creates a size x size Hadamard matrix using the Kronecker product"""
    if size == 2:
        return hadamard_matrix(2)
    h = hadamard(size/2)
    return block_matrix(2,2,[h,h,h,-h])

def max_index(v):
    """Returns the index with of the highest value in some vector"""
    def iter(remaining, max, maxi, i):
        if remaining:
            if v[i] > max:
                return iter(remaining[1:], v[i], i, i+1)
            return iter(remaining[1:], max, maxi, i+1)
        return maxi
    return iter(v, 0, 0, 0)

def generator(size):
    """
    Returns the generator matrix for "size" long words
    Same as walsh_matrix(size)
    """
    cols = product(*[[0,1] for _ in range(size)])
    return matrix(GF(2), map(lambda *args:[a for a in args], *cols))

def correct_error(r_msg):
    """
    Gets the received, coded message as input, and tries to find the
    original encoded message by calculating the syndrome, and taking the
    appropriate row of the Hadamard matrix
    """
    had = hadamard(len(r_msg))
    msg_prime = 2 * vector(ZZ, r_msg) - vector([1]*len(r_msg))
    syndrome = msg_prime * had
    index = max_index(list(map(abs, syndrome)))

    return vector(GF(2), ((2 * vector([1]*len(r_msg)) + had[index]) % 3))

def decoder_matrix(generator):
    # TODO
    """
    Returns the decoder matrix and the information set
    for a given generator matrix
    Used for decoding the error-corrected message
    """
    info_set = [2**i for i in range(generator.nrows())]
    Gtinv = generator.matrix_from_columns(info_set).inverse()
    Gtinv.set_immutable()
    return (Gtinv, info_set)

def encode(msg):
    """
    Encoding the message vector
    Basically just a vector-matrix multiplication, using the
    message and the generator matrix
    """
    return msg * generator(len(msg))

def decode(r_msg):
    """
    Decodes the received message by first correcting any errors (if possible),
    then getting back the original message with the decoder matrix
    """
    c_msg = correct_error(r_msg)

    U, info_set = decoder_matrix(generator(log(len(r_msg), 2)))
    cc = vector(GF(2), [c_msg[i] for i in info_set])
    return cc * U



# Sending end
msg = 'Hello world!'
c_msg = encode_text(msg)

# Communication Channel
v = VectorSpace(GF(2), 2^8) # 8 bit messages
c = channels.StaticErrorRateChannel(v, 100)
r_msg = map(c.transmit, c_msg)

# Receiving end
original = decode_text(r_msg)


# print(msg)
# c_msg = encode(msg)
# print(c_msg)
# print(decode(c_msg))

print(code_to_message(msg))

#print(decode(vector(GF(2), [1,0,1,1,1,0,1,0])))
