package org.ihtsdo.release.fileqa.mojo;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.Locale;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;
import org.apache.maven.doxia.markup.HtmlMarkup;
import org.apache.maven.doxia.sink.Sink;
import org.apache.maven.doxia.sink.SinkEventAttributeSet;
import org.apache.maven.doxia.sink.SinkEventAttributes;
import org.apache.maven.doxia.siterenderer.Renderer;
import org.apache.maven.project.MavenProject;
import org.apache.maven.reporting.AbstractMavenReport;
import org.apache.maven.reporting.MavenReportException;
import org.ihtsdo.release.fileqa.util.SinkUtilities;

/**
 * The <codebatchQACheck</code> class iterates through the concepts from a
 * viewpoint and preforms QA
 * 
 * @author termmed
 * @goal assertion-file-qa-report
 * @phase site
 */
public class FileQaWebReport extends AbstractMavenReport {
	/**
	 * The Maven Project Object
	 * 
	 * @parameter default-value="${project}"
	 * @required
	 * @readonly
	 */
	private MavenProject project;

	/**
	 * @component
	 * @required
	 * @readonly
	 */
	private Renderer siteRenderer;

	/**
	 * Specifies the directory where the report will be generated
	 * 
	 * @parameter default-value="${project.reporting.outputDirectory}"
	 * @required
	 */
	private String outputDirectory;

	private static final Logger log = Logger.getLogger(FileQaWebReport.class);

	@Override
	protected void executeReport(Locale arg0) throws MavenReportException {
		createReport();
	}

	private void createReport() {
		try {
			Sink sink = getSink();
			SinkUtilities.headAndTitle(sink, "Packaging process report");
			sink.body();

			log.info("Creating File QA Web Report");

			// DONE COPYING MANIFEST FILE TO SITE OUTPUT FOLDER

			sink.section2();
			sink.sectionTitle2();
			sink.text("Manifest File");
			sink.sectionTitle2_();

			SinkEventAttributes linkAttr = new SinkEventAttributeSet();
			linkAttr.addAttribute("href", "release-file-qa-report.xls");
			sink.unknown("a", new Object[] { new Integer(HtmlMarkup.TAG_TYPE_START) }, linkAttr);
			sink.text("Release File QA Report");
			sink.unknown("a", new Object[] { new Integer(HtmlMarkup.TAG_TYPE_END) }, null);

			sink.section2_();

			sink.body_();
			sink.flush();
			sink.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	protected MavenProject getProject() {
		return project;
	}

	@Override
	protected String getOutputDirectory() {
		return outputDirectory;
	}

	private ResourceBundle getBundle(Locale locale) {
		return ResourceBundle.getBundle("assertion-file-qa-report");
	}

	@Override
	public String getDescription(Locale locale) {
		return getBundle(locale).getString("report.name");
	}

	@Override
	public String getName(Locale locale) {
		return getBundle(locale).getString("report.name");
	}

	@Override
	public String getOutputName() {
		return project.getArtifactId();
	}

	@Override
	protected Renderer getSiteRenderer() {
		return siteRenderer;
	}
}
