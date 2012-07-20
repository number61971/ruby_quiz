#!/usr/bin/env python

import sys
import codecs

__all__ = ['find_anagrams', 'dictionary_words']

dictionary_words = set()
with codecs.open('/usr/share/dict/words', 'rb', 'utf-8') as fin:
    for line in fin:
        dictionary_words.add(line.rstrip())

anagrams_by_sorthash = {}
for word in dictionary_words:
    sorthash = ''.join(sorted(word.lower()))
    anagrams_by_sorthash.setdefault(sorthash, []).append(word)


def find_anagrams(word):
    """
    Find anagrams for any word in our dictionary file, case insensitively.

    """
    if word not in dictionary_words:
        if word.lower() in dictionary_words:
            word = word.lower()
        elif word.title() in dictionary_words:
            word = word.title()
        else:
            return ['Word not in dictionary']
    anagrams = anagrams_by_sorthash[''.join(sorted(word.lower()))]
    anagrams.remove(word)
    return anagrams


if __name__ == '__main__':
    if len(sys.argv) == 1:
        print 'Usage: anagrams.py <word> [<word> ...]'

    for word in sys.argv[1:]:
        anagrams = find_anagrams(word)
        print '%s: %s' % (word, ', '.join(anagrams))

