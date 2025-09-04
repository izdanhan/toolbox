#!/usr/bin/env python3
"""
Enhanced Markdown/HTML to PDF/EPUB Converter
With support for manual page breaks, EPUB generation, and combined markdown saving
"""

import argparse
import markdown
from weasyprint import HTML, CSS
import os
import tempfile
import re
import subprocess
import shutil
from pathlib import Path

def load_css(css_path=None):
    """Load CSS from file or return default CSS"""
    if css_path and os.path.exists(css_path):
        with open(css_path, 'r', encoding='utf-8') as f:
            return CSS(string=f.read())
    else:
        # Return default CSS with proper table styling and page break support
        return CSS(string='''
            @page {
                size: A4;
                margin: 1in;
                @top-right {
                    content: "Page " counter(page) " of " counter(pages);
                    font-family: "Fira Code", "Monaco", "Cascadia Code", "Source Code Pro", monospace;
                    font-size: 10pt;
                }
                @bottom-left {
                    content: "The Open Creator's Guide";
                    font-family: "Fira Code", "Monaco", "Cascadia Code", "Source Code Pro", monospace;
                    font-size: 10pt;
                }
            }
            
            body {
                font-family: "Helvetica", "Arial", sans-serif;
                line-height: 1.6;
                color: #333;
                max-width: 100%;
                margin: 0 auto;
                padding: 0;
            }
            
            h1, h2, h3, h4, h5, h6 {
                color: #2c3e50;
                font-weight: 600;
                margin-top: 1.5em;
                margin-bottom: 0.5em;
                page-break-after: avoid;
            }
            
            h1 {
                font-size: 24pt;
                border-bottom: 2px solid #3498db;
                padding-bottom: 0.3em;
                margin-top: 0;
            }
            
            h2 {
                font-size: 18pt;
                border-bottom: 1px solid #eaecef;
                padding-bottom: 0.3em;
            }
            
            h3 {
                font-size: 14pt;
            }
            
            p {
                margin: 0 0 1em 0;
                text-align: justify;
            }
            
            a {
                color: #3498db;
                text-decoration: none;
            }
            
            code {
                background-color: #f8f9fa;
                border-radius: 3px;
                padding: 0.2em 0.4em;
                font-family: "Fira Code", "Monaco", "Cascadia Code", "Source Code Pro", monospace;
                font-size: 0.9em;
            }
            
            pre {
                background-color: #f5f5f5;
                border: 1px solid #ddd;
                border-radius: 3px;
                padding: 1em;
                overflow: auto;
                font-family: "Fira Code", "Monaco", "Cascadia Code", "Source Code Pro", monospace;
                font-size: 0.9em;
                line-height: 1.4;
                page-break-inside: avoid;
                white-space: pre-wrap;
            }
            
            pre code {
                background: none;
                padding: 0;
                color: #333;
            }
            
            /* Directory tree specific styling */
            .directory-tree {
                background-color: #2d2d2d;
                color: #f8f8f2;
                border: 1px solid #444;
                border-radius: 4px;
                padding: 1em;
                font-family: "Fira Code", "Monaco", "Cascadia Code", "Source Code Pro", monospace;
                font-size: 0.85em;
                line-height: 1.3;
                overflow: auto;
                page-break-inside: avoid;
                white-space: pre;
            }
            
            .directory-tree .line {
                white-space: pre;
            }
            
            .directory-tree .file {
                color: #a8ff60;
            }
            
            .directory-tree .directory {
                color: #75d7ff;
                font-weight: bold;
            }
            
            .directory-tree .comment {
                color: #75715e;
                font-style: italic;
            }
            
            /* Page break styling */
            .page-break {
                page-break-after: always;
            }
            
            .page-break-before {
                page-break-before: always;
            }
            
            /* Table styling */
            table {
                border-collapse: collapse;
                width: 100%;
                margin-bottom: 1em;
                page-break-inside: avoid;
            }
            
            th, td {
                border: 1px solid #dfe2e5;
                padding: 0.5em;
                text-align: left;
            }
            
            th {
                background-color: #f6f8fa;
                font-weight: 600;
            }
            
            ul, ol {
                margin: 0 0 1em 0;
                padding-left: 2em;
            }
            
            li {
                margin: 0.25em 0;
            }
            
            hr {
                border: 0;
                height: 1px;
                background: #dfe2e5;
                margin: 2em 0;
            }
            
            .header {
                text-align: center;
                margin-bottom: 2em;
            }
            
            .title {
                font-size: 28pt;
                margin-bottom: 0.2em;
            }
            
            .subtitle {
                font-size: 14pt;
                color: #7f8c8d;
                margin-bottom: 1em;
            }
            
            .toc {
                margin-bottom: 2em;
                page-break-before: always;
            }
            
            .toc ul {
                list-style-type: none;
                padding-left: 0;
            }
            
            .toc li {
                margin: 0.5em 0;
            }
            
            .toc a {
                text-decoration: none;
                color: #2c3e50;
            }
            
            .toc a:hover {
                text-decoration: underline;
            }
            
            .chapter-title {
                page-break-before: always;
                padding-top: 1in;
            }
            
            .footer {
                text-align: center;
                font-size: 10pt;
                color: #7f8c8d;
                margin-top: 2em;
            }
        ''')

def handle_page_breaks(md_content):
    r"""Convert \newpage and \pagebreak commands to HTML divs with page-break classes"""
    # Replace \newpage and \pagebreak with div elements
    md_content = re.sub(r'\\newpage', '<div class="page-break"></div>', md_content)
    md_content = re.sub(r'\\pagebreak', '<div class="page-break"></div>', md_content)
    return md_content

def enhance_directory_trees(md_content):
    """Enhance directory tree markdown with terminal-like styling"""
    # Pattern to match directory tree code blocks
    tree_pattern = r'```(?:bash|shell|tree)?\n(.*?)\n```'
    
    def replace_tree(match):
        tree_content = match.group(1)
        # Convert to HTML with terminal styling
        html_tree = '<div class="directory-tree">\n'
        for line in tree_content.split('\n'):
            if line.strip():  # Only process non-empty lines
                # Check if line has a comment
                if '#' in line:
                    parts = line.split('#', 1)
                    line_content = parts[0].rstrip()
                    comment = parts[1].strip() if len(parts) > 1 else ''
                    
                    # Add classes for directories and files
                    if line_content.endswith('/'):
                        html_line = f'<span class="directory">{line_content}</span>'
                    else:
                        html_line = f'<span class="file">{line_content}</span>'
                    
                    if comment:
                        html_line += f' <span class="comment">#{comment}</span>'
                    
                    html_tree += f'<div class="line">{html_line}</div>\n'
                else:
                    # No comment, just the line
                    if line.endswith('/'):
                        html_tree += f'<div class="line"><span class="directory">{line}</span></div>\n'
                    else:
                        html_tree += f'<div class="line"><span class="file">{line}</span></div>\n'
        html_tree += '</div>'
        return html_tree
    
    # Replace all directory tree code blocks
    enhanced_content = re.sub(tree_pattern, replace_tree, md_content, flags=re.DOTALL)
    return enhanced_content

def convert_markdown_to_html(md_file_path, save_html=False, html_output_path=None):
    """Convert a markdown file to HTML with enhanced directory trees and page breaks"""
    
    # Read the markdown file
    with open(md_file_path, 'r', encoding='utf-8') as f:
        md_content = f.read()
    
    # Handle page breaks first
    md_content = handle_page_breaks(md_content)
    
    # Enhance directory trees
    enhanced_content = enhance_directory_trees(md_content)
    
    # Convert markdown to HTML with table support
    html_content = markdown.markdown(enhanced_content, extensions=[
        'extra',  # For tables, fenced code, etc.
        'codehilite',  # For code highlighting
        'toc'  # For table of contents
    ])
    
    # Create the full HTML document
    full_html = f"""
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="utf-8">
        <title>The Open Creator's Guide</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Fira+Code:wght@300;400;500;600;700&display=swap');
        </style>
    </head>
    <body>
        <div class="header">
            <h1 class="title">The Open Creator's Guide</h1>
            <div class="subtitle">Filming and Editing for YouTube</div>
        </div>
        
        {html_content}
        
        <div class="footer">
            <p>Created with Free and Open Source Software</p>
        </div>
    </body>
    </html>
    """
    
    # Save HTML if requested
    if save_html:
        if not html_output_path:
            # Save in same directory as input file
            html_output_path = os.path.splitext(md_file_path)[0] + '.html'
        
        with open(html_output_path, 'w', encoding='utf-8') as f:
            f.write(full_html)
        print(f"HTML saved to {html_output_path}")
    
    return full_html

def convert_html_to_pdf(html_content, pdf_file_path, css_path=None):
    """Convert HTML content to PDF with optional CSS"""
    css = load_css(css_path)
    HTML(string=html_content).write_pdf(pdf_file_path, stylesheets=[css])
    print(f"PDF saved to {pdf_file_path}")

def convert_markdown_to_epub(md_file_path, epub_file_path, css_path=None):
    """Convert a markdown file to EPUB using pandoc"""
    # Check if pandoc is available
    if not shutil.which("pandoc"):
        print("Error: pandoc is not installed. Please install pandoc to generate EPUB files.")
        print("On Fedora, you can install it with: sudo dnf install pandoc")
        return False
    
    # Build the pandoc command
    cmd = ["pandoc", md_file_path, "-o", epub_file_path, "--toc", "--toc-depth=2"]
    
    # Add CSS if provided
    if css_path and os.path.exists(css_path):
        cmd.extend(["--css", css_path])
    
    # Run pandoc
    try:
        result = subprocess.run(cmd, check=True, capture_output=True, text=True)
        print(f"EPUB saved to {epub_file_path}")
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error converting to EPUB: {e.stderr}")
        return False
    except FileNotFoundError:
        print("Error: pandoc is not installed. Please install pandoc to generate EPUB files.")
        print("On Fedora, you can install it with: sudo dnf install pandoc")
        return False

def convert_markdown_to_pdf(md_file_path, pdf_file_path, save_html=False, css_path=None):
    """Convert a markdown file to PDF with optional HTML intermediate"""
    html_content = convert_markdown_to_html(md_file_path, save_html)
    convert_html_to_pdf(html_content, pdf_file_path, css_path)

def convert_html_file_to_pdf(html_file_path, pdf_file_path, css_path=None):
    """Convert an HTML file directly to PDF"""
    with open(html_file_path, 'r', encoding='utf-8') as f:
        html_content = f.read()
    convert_html_to_pdf(html_content, pdf_file_path, css_path)

def combine_and_convert_files(file_list, output_pdf, save_html=False, css_path=None, save_md=False, epub=False):
    """Combine multiple markdown files and convert to a single PDF and/or EPUB"""
    
    combined_content = ""
    
    # Read and combine all files
    for file_path in file_list:
        if os.path.exists(file_path):
            with open(file_path, 'r', encoding='utf-8') as f:
                # Add chapter header
                chapter_name = os.path.splitext(os.path.basename(file_path))[0].replace('_', ' ').title()
                combined_content += f"# {chapter_name}\n\n"
                combined_content += f.read() + "\n\n---\n\n"
        else:
            print(f"Warning: File {file_path} not found")
    
    # Create output markdown file if requested
    md_output_path = None
    if save_md:
        md_output_path = os.path.splitext(output_pdf)[0] + '.md'
        with open(md_output_path, 'w', encoding='utf-8') as f:
            f.write(combined_content)
        print(f"Combined markdown saved to {md_output_path}")
    
    # Create a temporary markdown file for processing
    temp_path = "combined_chapters.md"
    with open(temp_path, 'w', encoding='utf-8') as temp_file:
        temp_file.write(combined_content)
    
    try:
        # Set HTML output path to match PDF name if requested
        html_output_path = os.path.splitext(output_pdf)[0] + '.html' if save_html else None
        
        # Convert to PDF
        html_content = convert_markdown_to_html(temp_path, save_html, html_output_path)
        convert_html_to_pdf(html_content, output_pdf, css_path)
        
        # Convert to EPUB if requested
        if epub:
            epub_file_path = os.path.splitext(output_pdf)[0] + '.epub'
            convert_markdown_to_epub(temp_path, epub_file_path, css_path)
            
    finally:
        # Clean up the temporary file
        if os.path.exists(temp_path):
            os.unlink(temp_path)

def main():
    # Create argument parser with custom help
    parser = argparse.ArgumentParser(
        description='Convert markdown or HTML files to PDF/EPUB with proper table support and page breaks',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=r'''
Examples:
  # Convert a single markdown file to PDF
  %(prog)s chapter_001.md -o chapter_001.pdf
  
  # Convert a single markdown file and save intermediate HTML
  %(prog)s chapter_001.md --save-html -o chapter_001.pdf
  
  # Convert with custom CSS styling
  %(prog)s chapter_001.md --css custom-style.css -o chapter_001.pdf
  
  # Combine multiple markdown files into a single PDF
  %(prog)s chapter_*.md appendix.md -o complete_guide.pdf
  
  # Combine files and save the combined markdown
  %(prog)s chapter_*.md appendix.md -o guide.pdf --save-md
  
  # Combine files and generate both PDF and EPUB
  %(prog)s chapter_*.md appendix.md -o guide.pdf --epub
  
  # Convert an HTML file to PDF
  %(prog)s document.html --html -o document.pdf
  
Page Breaks:
  Add \newpage or \pagebreak in your markdown to force a page break in the PDF.
'''
    )
    
    parser.add_argument('input_files', nargs='+', help='Input files to convert')
    parser.add_argument('-o', '--output', default='output.pdf',
                       help='Output PDF file name (default: output.pdf)')
    parser.add_argument('--html', action='store_true',
                       help='Input files are HTML (default is Markdown)')
    parser.add_argument('--css', help='External CSS file for styling')
    parser.add_argument('--save-html', action='store_true',
                       help='Save intermediate HTML file')
    parser.add_argument('--html-output', help='Custom path for HTML output (overrides automatic naming)')
    parser.add_argument('--save-md', action='store_true',
                       help='Save combined markdown file (when combining multiple files)')
    parser.add_argument('--epub', action='store_true',
                       help='Generate EPUB file in addition to PDF')
    
    args = parser.parse_args()
    
    if args.html:
        # HTML to PDF conversion
        if len(args.input_files) > 1:
            print("Warning: Multiple HTML files provided. Only the first one will be used.")
        
        convert_html_file_to_pdf(args.input_files[0], args.output, args.css)
    else:
        # Markdown to PDF conversion
        if len(args.input_files) > 1:
            combine_and_convert_files(
                args.input_files, 
                args.output, 
                args.save_html, 
                args.css,
                args.save_md,
                args.epub
            )
        else:
            # For single file, set HTML output path to match PDF name if requested
            html_output_path = None
            if args.save_html:
                html_output_path = args.html_output if args.html_output else os.path.splitext(args.output)[0] + '.html'
            
            # Convert to PDF
            html_content = convert_markdown_to_html(
                args.input_files[0], 
                args.save_html, 
                html_output_path
            )
            convert_html_to_pdf(
                html_content, 
                args.output, 
                args.css
            )
            
            # Convert to EPUB if requested
            if args.epub:
                epub_file_path = os.path.splitext(args.output)[0] + '.epub'
                convert_markdown_to_epub(args.input_files[0], epub_file_path, args.css)

if __name__ == "__main__":
    main()