import kotlineo.*
import org.junit.jupiter.api.*
import org.junit.jupiter.api.Assertions.*


class KotlineoTest {
    @Test
    fun testRandomChromosome() {
        val length = 10
        val actual = random_chromosome(length)

        assertEquals(length, actual.size)
        // every element should be either true or false
        for (i in 0..length-1) {
            assertTrue(actual[i] == true || actual[i] == false)
        }
    }

    @Test
    fun testCrossover() {
        val chromosome1 = booleanArrayOf(true, false, true, false, true)
        val chromosome2 = booleanArrayOf(false, true, false, true, false)
        val copy_chromosome1 = chromosome1.copyOf()
        val copy_chromosome2 = chromosome2.copyOf()
        val actual = crossover(chromosome1, chromosome2)

        assertEquals(copy_chromosome1, actual[0].size)
        assertEquals(copy_chromosome2, actual[1].size)

        assertNotEquals(copy_chromosome1, actual[0])
        assertNotEquals(copy_chromosome2, actual[1])

    }

    @Test
    fun testHIFF() {
        val subjects = mapOf(
            "10" to 2,
            "1100" to 8,
            "1011" to 6,
            "10101101100100" to 16,
            "1010110110010011" to 22,
            "010101101100100" to 19,
            "00000000100000" to 42,
            "1111111110000110" to 42,
            "0010110100101101" to 24
        )

        var manyHIFF = ""
        subjects.forEach { (input, expected) ->
            manyHIFF += input
            assertEquals(expected, hiff(input), "HIFF $input = $expected")
        }
        assertEquals(163, hiff(manyHIFF), "Many HIFF")
    }
}
