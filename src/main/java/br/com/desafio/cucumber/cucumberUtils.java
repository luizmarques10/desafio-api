package br.com.desafio.cucumber;

import com.google.gson.JsonArray;
import com.intuit.karate.core.ScenarioResult;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

public class cucumberUtils {

    public String getFeatureName(ScenarioResult scenarioResult) {
        return scenarioResult.getScenario().getFeature().getName();
    }

    public String getScenarioName(ScenarioResult scenarioResult) {
        return scenarioResult.getScenario().getName();
    }

    public String getResponsibleName(ScenarioResult scenarioResult) {
        return scenarioResult.getScenario()
                .getTags()
                .stream()
                .filter(tag -> tag.toString().contains("@#"))
                .collect(Collectors.toList())
                .get(0)
                .toString()
                .replace("@#", "");
    }

    public boolean isErrorMessage(ScenarioResult scenarioResult) {
        try {
            scenarioResult.getError().getMessage();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public String getErrorMessage(ScenarioResult scenarioResult) {
        try {
            final String message = scenarioResult.getError().getMessage();
            return message;
        } catch (Exception e) {
            return "N/A";
        }
    }

    public List<String> getResponsibles(JsonArray responsibles) {
        List<String> responsible = new ArrayList<String>();
        Iterator iterator = responsibles.get(0).getAsJsonObject().keySet().iterator();
        while (iterator.hasNext()) {
            String key = (String) iterator.next();
            responsible.add(key);
        }
        return responsible;
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "karate-api");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
