import hammer as h
abcd = h.sequence(h.many1(h.uint8()),h.many(h.uint16()),h.sequence(h.uint8()))
efgh = h.sequence(h.many1(h.uint8()),h.many(h.uint16()),h.sequence(h.uint8()))
