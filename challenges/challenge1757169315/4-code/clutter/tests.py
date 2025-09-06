import unittest
from utils import calculate_sum

class TestUtils(unittest.TestCase):

    def test_calculate_sum(self):
        self.assertEqual(calculate_sum(2, 3), 5)
        self.assertEqual(calculate_sum(-1, 1), 0)
        self.assertEqual(calculate_sum(0, 0), 0)

if __name__ == '__main__':
    unittest.main()
