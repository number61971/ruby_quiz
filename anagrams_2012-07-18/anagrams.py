#!/usr/bin/env python

import itertools
import re

f = open('/usr/share/dict/words')
all_words = f.read()

all_anagrams = []
f.seek(0)
for i, word in enumerate(f.readlines()):
  anagrams = []
  word = word.strip().lower()
  if len(word) < 5:
    permutations = set(itertools.permutations(word))
    num_perms = len(permutations)
    print '%(i)s %(word)s: %(num_perms)s potential anagrams...' % locals()
    for p in permutations:
      w = ''.join(p)
      if re.search('^%s$' % w, all_words, re.IGNORECASE + re.MULTILINE):
        anagrams.append(w)
    if len(anagrams) > 1:
      all_anagrams.append( tuple(sorted(anagrams)) ) 
  if i > 1000: break

all_anagrams = sorted(set(all_anagrams), lambda a,b: cmp(len(b), len(a)))
for a in all_anagrams:
  print a
