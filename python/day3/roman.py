#!/usr/bin/env python

# Roman numbers (with some meta programming)

class ClassAttributeInterceptor(type):

    def __getattr__(cls, name):
        return cls.classfeature_missing(name)
        
    def classfeature_missing(cls, name):
        pass
        

class Roman(object):

    __metaclass__ = ClassAttributeInterceptor

    @classmethod
    def classfeature_missing(cls, name):
        return Roman.to_int(name)
                    
    @classmethod
    def to_int(cls, roman):
        roman = roman.replace('IV', 'IIII')
        roman = roman.replace('IX', 'VIII')
        roman = roman.replace('XL', 'XXXX')
        roman = roman.replace('XC', 'LXXXX')
        roman = roman.replace('CD', 'CCCC')
        roman = roman.replace('CM', 'DCCCC')
    
        result = (roman.count('I')
            + roman.count('V') * 5
            + roman.count('X') * 10
            + roman.count('L') * 50
            + roman.count('C') * 100
            + roman.count('D') * 500
            + roman.count('M') * 1000)
        return result
    

# Regular class method calls
print "%s" % Roman.to_int('X')
print "%s" % Roman.to_int('XC')
print "%s" % Roman.to_int('MCMLXXXIV')

# via ClassAttributeInterceptor
print "%s" % Roman.MCMLXXXIV

