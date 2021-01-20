#!/usr/bin/env python

import sys
import unittest
import PAM

class PAMConstructorTestCase(unittest.TestCase):

    def testConstructor(self):
        """The constructor works with no arguements and fails with
        a TypeError when called with any arguments."""
        
        pam = PAM.pam()
        self.assertRaises(TypeError, PAM.pam, None)
        self.assertRaises(TypeError, PAM.pam, 1)
        self.assertRaises(TypeError, PAM.pam, "")
        self.assertRaises(TypeError, PAM.pam, ())
        self.assertRaises(TypeError, PAM.pam, [])
        self.assertRaises(TypeError, PAM.pam, {})


class PAMTestCase(unittest.TestCase):

    def setUp(self):
    
        self.pam = PAM.pam()

    def test_get_userdata_interface(self):
        """get_userdata() raises TypeError when called with any arguments."""

        self.assertRaises(TypeError, self.pam.get_userdata, 1)

    def test_set_userdata_interface(self):
        """set_userdata() raises TypeError when called with 0 arguments
        or with more than 1 argument."""
        
        self.assertRaises(TypeError, self.pam.set_userdata)
        self.assertRaises(TypeError, self.pam.set_userdata, 1, 2)


    def test_userdata_default(self):
        """The default value for userdata is None."""
    
        self.failUnless(self.pam.get_userdata() is None)

    def test_userdata(self):
        """The userdata getter and setter will store and return any data."""
    
        self.pam.set_userdata(1)
        self.failUnless(self.pam.get_userdata() == 1)

    def test_start(self):
        """pam.start() works as expected."""
        
        self.assertRaises(TypeError, self.pam.start)
        self.assertRaises(TypeError, self.pam.start, 1)
        

if __name__ == '__main__':

    unittest.main()
