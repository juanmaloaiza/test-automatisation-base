package marvel;

import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }

    @Karate.Test
    Karate testBasic() {
       /* Runner.path("classpath:marvel").tags("~@ignore").parallel(4);

        // Reporte en cucumber
        Results results = Runner.path("classpath:marvel").outputCucumberJson(true).tags("~@ignore").parallel(4);
        generateReport(results.getReportDir());*/

        return Karate.run("classpath:marvelApi.feature");

    }

    public static void generateReport(String karateOutputPath) {
        try {
            Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
            if (jsonFiles.isEmpty()) {
                System.err.println("No se encontraron archivos JSON en: " + karateOutputPath);
                return;
            }
            List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
            jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
            Configuration config = new Configuration(new File("build"), "KarateApiTest");
            ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
            reportBuilder.generateReports();
        } catch (Exception e) {
            System.err.println("Error al generar el reporte: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
