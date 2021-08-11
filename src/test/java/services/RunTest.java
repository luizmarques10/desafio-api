package services;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static br.com.desafio.cucumber.cucumberUtils.generateReport;


public class RunTest {

    private static final Logger log = LoggerFactory.getLogger(RunTest.class);

    @Test
    void runTests() {

        //Test classpath
        Runner.Builder testBuilder = Runner.path("classpath:services");

        //Tags setup
        //testBuilder.tags("@id");


        String env = System.getProperty("karate.env");
        String tags = System.getProperty("karate.options");

        //Parallel setup
        String threadsProperty = System.getProperty("threads");
        int numberOfThreads = 1;

        if (threadsProperty != null) {
            try {
                numberOfThreads = Integer.parseInt(threadsProperty);
            } catch (NumberFormatException err) {
                log.warn(err.toString());
                log.warn("Fallback to single thread execution...");
            }
        }

        //Run tests
        Results results = testBuilder.parallel(numberOfThreads);
        generateReport(results.getReportDir());
    }
}
