import kotlineo.*
import org.junit.Test
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue

class KotlineoTests {
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

}