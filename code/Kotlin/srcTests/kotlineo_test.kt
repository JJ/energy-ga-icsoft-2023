import kotlineo.*

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

}