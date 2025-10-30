const fs = require('fs');
const path = require('path');
const glob = require('glob');
const { execSync } = require('child_process');

class OCRFileConverter {
  constructor() {
    this.conversions = 0;
    this.ocrGenerated = 0;
  }

  // Convert markdown content to structured JSON (reuse from main converter)
  markdownToJson(mdContent, filePath) {
    const lines = mdContent.split('\n');
    const result = {
      title: '',
      source_file: path.resolve(filePath),
      created_at: new Date().toISOString(),
      file_type: 'markdown',
      generated_via: 'ocr',
      sections: []
    };

    let currentSection = null;
    let currentSubsection = null;
    let currentContent = [];

    for (const line of lines) {
      // Extract title from first heading
      if (line.match(/^#\s+/) && !result.title) {
        result.title = line.substring(1).trim();
        continue;
      }

      // Handle headings
      const headingMatch = line.match(/^(#{1,6})\s+(.*)$/);
      if (headingMatch) {
        const level = headingMatch[1].length;
        const heading = headingMatch[2].trim();

        // Save previous content
        if (currentSubsection) {
          currentSubsection.content = currentContent.join('\n').trim();
        } else if (currentSection) {
          currentSection.content = currentContent.join('\n').trim();
        }
        currentContent = [];

        if (level === 2) {
          // New main section
          if (currentSection) {
            result.sections.push(currentSection);
          }
          currentSection = {
            heading: heading,
            level: level,
            content: '',
            subsections: []
          };
          currentSubsection = null;
        } else if (level >= 3 && currentSection) {
          // New subsection
          if (currentSubsection) {
            currentSection.subsections.push(currentSubsection);
          }
          currentSubsection = {
            heading: heading,
            level: level,
            content: ''
          };
        }
      } else {
        // Regular content line
        currentContent.push(line);
      }
    }

    // Save final content
    if (currentSubsection) {
      currentSubsection.content = currentContent.join('\n').trim();
      if (currentSection) currentSection.subsections.push(currentSubsection);
    } else if (currentSection) {
      currentSection.content = currentContent.join('\n').trim();
    }

    if (currentSection) {
      result.sections.push(currentSection);
    }

    // If no structured sections found, put all content in a single section
    if (result.sections.length === 0 && lines.length > 0) {
      result.sections.push({
        heading: result.title || 'OCR Document Content',
        level: 2,
        content: lines.join('\n').trim(),
        subsections: []
      });
    }

    return result;
  }

  // Perform OCR on image file
  performOCR(imagePath) {
    try {
      const baseName = path.basename(imagePath, path.extname(imagePath));
      const tempTxtFile = `/tmp/${baseName}.txt`;
      
      console.log(`🧠 Performing OCR on: ${imagePath}`);
      
      // Run tesseract OCR
      execSync(`tesseract "${imagePath}" "/tmp/${baseName}" --dpi 300 -l eng`, { stdio: 'pipe' });
      
      if (fs.existsSync(tempTxtFile)) {
        const ocrText = fs.readFileSync(tempTxtFile, 'utf8').trim();
        fs.unlinkSync(tempTxtFile); // Clean up temp file
        
        if (ocrText.length > 0) {
          return ocrText;
        }
      }
      return null;
    } catch (error) {
      console.error(`❌ OCR failed for ${imagePath}:`, error.message);
      return null;
    }
  }

  // Process image files for missing representations
  processImageFiles() {
    console.log('🔄 Processing image files for OCR conversion...');
    
    // Find all image files
    const imageFiles = glob.sync('**/*.{png,jpg,jpeg,gif,bmp}', { 
      ignore: ['node_modules/**', 'vendor/**', 'bower_components/**', 'jspm_packages/**', '.bundle/**', 'target/**', 'build/**', 'dist/**', '.git/**'] 
    });

    console.log(`Found ${imageFiles.length} image files`);

    if (imageFiles.length === 0) {
      console.log('ℹ️  No image files found - OCR processing not needed');
      return 0;
    }

    for (const imageFile of imageFiles) {
      const baseName = imageFile.replace(/\.(png|jpg|jpeg|gif|bmp)$/i, '');
      const mdFile = `${baseName}.md`;
      const jsonFile = `${baseName}.json`;

      let ocrText = null;

      // Generate missing Markdown file via OCR
      if (!fs.existsSync(mdFile)) {
        ocrText = ocrText || this.performOCR(imageFile);
        if (ocrText) {
          try {
            // Create markdown content with OCR text
            const mdContent = `# ${path.basename(baseName)}\n\n<!-- Generated via OCR from ${imageFile} -->\n<!-- Created: ${new Date().toISOString()} -->\n\n## OCR Content\n\n${ocrText}\n`;
            
            // Ensure directory exists
            const dir = path.dirname(mdFile);
            if (!fs.existsSync(dir)) {
              fs.mkdirSync(dir, { recursive: true });
            }
            
            fs.writeFileSync(mdFile, mdContent);
            console.log(`✅ Generated Markdown via OCR: ${mdFile}`);
            this.ocrGenerated++;
          } catch (error) {
            console.error(`❌ Error creating markdown file ${mdFile}:`, error.message);
          }
        }
      }

      // Generate missing JSON file via OCR + conversion
      if (!fs.existsSync(jsonFile)) {
        ocrText = ocrText || this.performOCR(imageFile);
        if (ocrText) {
          try {
            // Create markdown content first
            const tempMdContent = `# ${path.basename(baseName)}\n\n## OCR Content\n\n${ocrText}\n`;
            
            // Convert to JSON structure
            const jsonData = this.markdownToJson(tempMdContent, imageFile);
            
            // Ensure directory exists
            const dir = path.dirname(jsonFile);
            if (!fs.existsSync(dir)) {
              fs.mkdirSync(dir, { recursive: true });
            }
            
            fs.writeFileSync(jsonFile, JSON.stringify(jsonData, null, 2));
            console.log(`✅ Generated JSON via OCR: ${jsonFile}`);
            this.ocrGenerated++;
          } catch (error) {
            console.error(`❌ Error creating JSON file ${jsonFile}:`, error.message);
          }
        }
      }
    }

    return this.ocrGenerated;
  }
}

// Run the OCR conversion
const converter = new OCRFileConverter();
const totalGenerated = converter.processImageFiles();
console.log(`\n🎉 OCR processing complete! Generated ${totalGenerated} files from images.`);

// Exit with appropriate code
process.exit(0);
