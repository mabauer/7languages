#!/usr/bin/env python

# Roman numbers (with some meta programming)

class ClassMethodInterceptor(type):

    def __getattr__(cls, name):
        print name
        return lambda *args, **kwargs: \
                   cls.classmethod_missing(name, *args, **kwargs)

    def classmethod_missing(cls, name, *args, **kwargs):
        e = "type object '%s' has no attribute '%s'" \
            % (cls.__name__, name)
        raise AttributeError(e)
        

class Roman(object):

    __metaclass__ = ClassMethodInterceptor

    def __init__(self):
        pass

    def __getattribute__(self, name):
        try:
            return object.__getattribute__(self, name) 
        except AttributeError:
            return lambda *args, **kwargs: \
                   self.method_missing(name, *args, **kwargs)
                   
    def method_missing(self, name, *args, **kwargs):
        print "Debug: method missing: %s: args=%s, kwargs=%s" % (name, args, kwargs)
        return Roman.to_int(name)
            
    @classmethod
    def classmethod_missing(cls, name, *args, **kwargs):
        print "Debug: class method missing: %s: args=%s, kwargs=%s" % (name, args, kwargs)
        return cls.to_int(name)
        
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

# Via method_missing hooks
print "%s" % Roman().MCMLXXXIV()
print "%s" % Roman.MCMLXXXIV()


