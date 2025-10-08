# PrivacyVault

# NAME OF PROJECT:
================
Privacy Vault


# NAME OF PROGRAMMER:
===================
Ben Lambert


# STATEMENT:
==========
I have neither given nor received unauthorized assistance on this work.


# PROGRAM DESCRIPTION:
=====================
This file encryption tool was developed to provide secure file encryption and decryption capabilities using industry-standard AES-256-CBC encryption. The program supports the **confidentiality principle** of information security by ensuring that sensitive data remains protected from unauthorized access through strong cryptographic methods.


# SPECIAL INSTRUCTIONS:
=====================

## Project Structure

The project files are organized as follows:

```
file-encryption-app/
├── app/
│   ├── controllers/
│   │   └── encryption_controller.rb    # Main controller handling encryption/decryption
│   └── views/
│       └── encryption/
│           └── index.html.erb           # Main user interface
├── config/
│   └── routes.rb                        # Application routes configuration
├── Gemfile                              # Ruby gem dependencies
└── README.md                            # This file
```

## File Descriptions

### 1. encryption_controller.rb
**Purpose:** Contains the core encryption and decryption logic using OpenSSL with AES-256-CBC algorithm.

**Key Features:**
- Implements AES-256-CBC encryption with random IV generation
- Uses PBKDF2-HMAC-SHA256 for secure key derivation from passwords
- Handles file upload, encryption/decryption, and download
- Includes comprehensive error handling

### 2. index.html.erb
**Purpose:** Provides the user-friendly web interface for file encryption and decryption.

**Key Features:**
- Modern, responsive design inspired by cloud conversion services
- Tabbed interface for encryption and decryption operations
- Drag-and-drop file upload support
- Password input with validation
- Real-time feedback and loading indicators
- Security information display

### 3. routes.rb
**Purpose:** Defines the application URL routes and maps them to controller actions.

### 4. Gemfile
**Purpose:** Specifies all Ruby gem dependencies required for the application.


# SETUP INSTRUCTIONS:
====================

## Prerequisites

Before setting up this application, ensure you have the following installed on your system:

1. **Ruby** (version 3.0 or higher)
   - Download from: https://www.ruby-lang.org/en/downloads/
   - Verify installation: `ruby -v`

2. **Rails** (version 7.0 or higher)
   - Install via: `gem install rails`
   - Verify installation: `rails -v`

3. **Bundler** (for managing gem dependencies)
   - Install via: `gem install bundler`
   - Verify installation: `bundler -v`

4. **OpenSSL** (typically included with Ruby)
   - Verify installation: `ruby -ropenssl -e 'puts OpenSSL::VERSION'`

## Installation Steps

### Step 1: Create a New Rails Application

Open your terminal/command prompt and run:

```bash
rails new file-encryption-app
cd file-encryption-app
```

### Step 2: Install Dependencies

Update your Gemfile with the provided Gemfile content, then run:

```bash
bundle install
```

### Step 3: Create the Controller

Create the encryption controller:

```bash
rails generate controller Encryption index
```

Replace the contents of `app/controllers/encryption_controller.rb` with the provided controller code.

### Step 4: Configure Routes

Replace the contents of `config/routes.rb` with the provided routes configuration.

### Step 5: Update the View

Replace the contents of `app/views/encryption/index.html.erb` with the provided view template.

### Step 6: Disable CSRF Protection (Optional for Development)

Since we're handling file uploads without traditional form authenticity tokens, the controller includes `skip_before_action :verify_authenticity_token`. For production use, you may want to implement proper CSRF protection.


# RUNNING THE APPLICATION:
==========================

## Starting the Server

From the project root directory, run:

```bash
rails server
```

or the shorthand:

```bash
rails s
```

The application will start on **http://localhost:3000** by default.

## Accessing the Application

1. Open your web browser
2. Navigate to: **http://localhost:3000**
3. You should see the File Encryption Tool interface


# HOW TO USE THE APPLICATION:
==============================

## Encrypting a File

1. **Navigate to the Encrypt Tab** (selected by default)
2. **Upload a File:**
   - Click on the upload area, OR
   - Drag and drop a file onto the upload area
3. **Enter a Password:**
   - Type a strong password (minimum 8 characters)
   - Remember this password - you'll need it to decrypt the file
4. **Click "Encrypt File"**
5. **Download:** The encrypted file (with .enc extension) will automatically download

## Decrypting a File

1. **Navigate to the Decrypt Tab**
2. **Upload the Encrypted File:**
   - Click on the upload area, OR
   - Drag and drop your .enc file onto the upload area
3. **Enter the Password:**
   - Type the same password you used for encryption
4. **Click "Decrypt File"**
5. **Download:** The decrypted original file will automatically download

## Important Notes

- **Password Security:** Use strong, unique passwords for encryption
- **Password Recovery:** If you forget your password, the file cannot be decrypted
- **File Size:** The application can handle files of various sizes, but very large files may take longer to process
- **File Privacy:** Files are processed in memory and are NOT stored on the server
- **Encryption Algorithm:** Uses AES-256-CBC with PBKDF2 key derivation (100,000 iterations)


# SECURITY FEATURES:
===================

## Encryption Details

- **Algorithm:** AES-256-CBC (Advanced Encryption Standard with 256-bit keys in Cipher Block Chaining mode)
- **Key Derivation:** PBKDF2-HMAC-SHA256 with 100,000 iterations
- **Initialization Vector (IV):** Randomly generated 16-byte IV for each encryption operation
- **Salt:** Randomly generated 16-byte salt for key derivation

## Security Principle

This application supports the **Confidentiality** principle of information security:

- **Confidentiality** ensures that sensitive information is accessible only to authorized parties
- By encrypting files with strong cryptographic algorithms, the application prevents unauthorized access to file contents
- Even if an encrypted file is intercepted, it cannot be read without the correct password

## File Structure

Encrypted files contain:
1. Salt (16 bytes) - Used for key derivation
2. IV (16 bytes) - Initialization vector for AES
3. Encrypted data (variable length) - The actual encrypted file content


# TROUBLESHOOTING:
==================

## Common Issues and Solutions

### 1. "Bundle install failed"
**Solution:** Make sure you have Ruby and Bundler properly installed. Try running:
```bash
gem update --system
gem install bundler
bundle install
```

### 2. "Rails server won't start"
**Solution:** 
- Check if port 3000 is already in use: `lsof -i :3000` (Mac/Linux) or `netstat -ano | findstr :3000` (Windows)
- Kill the process or use a different port: `rails s -p 3001`

### 3. "Decryption failed: Invalid password"
**Solution:** 
- Verify you're using the correct password
- Ensure the .enc file hasn't been corrupted
- Make sure you're decrypting a file that was encrypted with this tool

### 4. "OpenSSL not found"
**Solution:** 
- Reinstall Ruby with OpenSSL support
- On Ubuntu/Debian: `sudo apt-get install libssl-dev`
- On macOS: OpenSSL should be included with Ruby

### 5. "File upload not working"
**Solution:** 
- Check your browser console for JavaScript errors
- Ensure file size is reasonable (very large files may timeout)
- Try a different browser


# TECHNICAL REQUIREMENTS MET:
=============================

**OpenSSL Integration:** Uses Ruby's OpenSSL library for cryptographic operations

**AES-256-CBC Encryption:** Implements AES-256 algorithm in CBC mode as specified

**Random IV Generation:** Creates a unique 16-byte initialization vector for each file

**IV Storage:** Prepends the IV and salt to the encrypted file for retrieval during decryption

**User-Friendly Interface:** Modern web interface resembling cloud conversion services

**File Upload/Download:** Supports file upload for encryption/decryption with automatic download

**Security Principle:** Explicitly supports the Confidentiality principle of information security


# ADDITIONAL FEATURES:
======================

- **Password-Based Key Derivation:** Implements PBKDF2 with 100,000 iterations for enhanced security
- **Drag-and-Drop Support:** Users can drag files directly onto upload areas
- **Real-Time Feedback:** Visual indicators for upload status, processing, and errors
- **Responsive Design:** Works on desktop, tablet, and mobile devices
- **No Server Storage:** Files are processed in memory and immediately deleted after download
- **Error Handling:** Comprehensive error messages for troubleshooting


# DEPENDENCIES:
===============

The application requires the following Ruby gems:

- **rails** (~> 7.0) - Web application framework
- **puma** (~> 5.0) - Web server
- **sqlite3** (~> 1.4) - Database (for session management, not file storage)
- **bootsnap** - Reduces boot times through caching
- **debug** - Debugging tools (development only)
- **web-console** - Interactive console in browser (development only)

All dependencies are managed through Bundler and specified in the Gemfile.


# TESTING THE APPLICATION:
===========================

## Manual Testing Steps

### Test 1: Basic Encryption/Decryption
1. Create a simple text file with known content
2. Encrypt the file with password "TestPassword123"
3. Verify the .enc file is downloaded
4. Decrypt the .enc file with the same password
5. Verify the decrypted content matches the original

### Test 2: Different File Types
Test with various file types to ensure compatibility:
- Text files (.txt)
- Images (.jpg, .png, .gif)
- Documents (.pdf, .docx)
- Archives (.zip, .tar.gz)
- Binary files (.exe, .bin)

### Test 3: Password Validation
1. Try encrypting with a password shorter than 8 characters (should fail)
2. Try decrypting with wrong password (should show error)
3. Verify correct password works

### Test 4: Large Files
Test with files of varying sizes to check performance:
- Small: < 1 MB
- Medium: 1-10 MB
- Large: > 10 MB

### Test 5: Edge Cases
- Empty files
- Files with special characters in names
- Files without extensions
- Already encrypted files


# DEPLOYMENT CONSIDERATIONS:
=============================

## For Production Use

If you plan to deploy this application to production, consider the following:

### 1. Security Enhancements
- Enable proper CSRF protection
- Implement rate limiting to prevent abuse
- Add HTTPS/SSL certificate for secure transmission
- Set up proper authentication if needed
- Configure maximum file size limits

### 2. Performance Optimization
- Use a production-grade web server (e.g., Nginx + Puma)
- Implement background job processing for large files (e.g., Sidekiq)
- Add file size validation before processing
- Configure appropriate timeouts

### 3. Hosting Options
- **Heroku:** Simple deployment with git push
- **AWS Elastic Beanstalk:** Scalable cloud hosting
- **DigitalOcean:** VPS with full control
- **Render:** Modern cloud platform

### 4. Environment Configuration
Update `config/environments/production.rb` for production settings:
```ruby
config.force_ssl = true
config.log_level = :info
config.cache_classes = true
```

### 5. Database
While this application doesn't store files, consider using PostgreSQL instead of SQLite for production:
```ruby
gem 'pg' # In Gemfile
```


# ALGORITHM EXPLANATION:
========================

## Encryption Process

1. **File Upload:** User selects a file and enters a password
2. **Salt Generation:** 16 random bytes are generated as salt
3. **Key Derivation:** Password + salt → PBKDF2-HMAC-SHA256 (100,000 iterations) → 32-byte key
4. **IV Generation:** 16 random bytes are generated as initialization vector
5. **AES Encryption:** File content is encrypted using AES-256-CBC with the derived key and IV
6. **Output Assembly:** Salt + IV + Encrypted Data are concatenated
7. **Download:** Combined data is sent to user as .enc file

## Decryption Process

1. **File Upload:** User uploads .enc file and enters password
2. **Data Extraction:** First 16 bytes (salt) and next 16 bytes (IV) are extracted
3. **Key Derivation:** Password + extracted salt → PBKDF2 → 32-byte key (same as encryption)
4. **AES Decryption:** Remaining data is decrypted using AES-256-CBC with derived key and extracted IV
5. **Download:** Decrypted data is sent to user as original file

## Why These Choices?

- **AES-256:** Industry standard, approved by NSA for TOP SECRET information
- **CBC Mode:** Provides semantic security, each block depends on previous blocks
- **Random IV:** Ensures identical files produce different ciphertexts
- **PBKDF2:** Slows down brute-force attacks through computational cost
- **100,000 Iterations:** Balances security and performance (OWASP recommendation)


# FUTURE ENHANCEMENTS:
======================

Possible improvements for future versions:

1. **Multiple File Encryption:** Encrypt multiple files at once
2. **Compression:** Compress files before encryption to reduce size
3. **Key File Support:** Option to use key files in addition to passwords
4. **Encryption History:** Track encrypted files (without storing them)
5. **Password Strength Meter:** Visual indicator of password strength
6. **Batch Operations:** Process multiple files in queue
7. **API Support:** RESTful API for programmatic access
8. **File Integrity Checks:** Add HMAC for authentication
9. **Progress Indicators:** Show percentage for large files
10. **Cloud Storage Integration:** Optional integration with cloud storage providers


# ACADEMIC INTEGRITY:
=====================

This project was completed in accordance with academic integrity policies. All code is original work written specifically for this assignment, utilizing standard libraries and frameworks as permitted. The implementation demonstrates understanding of:

- Cryptographic principles and best practices
- Secure key derivation techniques
- Proper initialization vector usage
- File handling and streaming
- Web application security
- User interface design


# REFERENCES:
=============

1. National Institute of Standards and Technology. (2023). FIPS 197: Federal Information Processing Standards Publication Advanced Encryption Standard (AES). https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.197-upd1.pdf

2. OpenSSL Documentation. Ruby OpenSSL Library. https://ruby-doc.org/stdlib-3.0.0/libdoc/openssl/rdoc/OpenSSL.html

3. OWASP. Password Storage Cheat Sheet. https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html

4. Ruby on Rails Guides. https://guides.rubyonrails.org/

5. Active Record Encryption .https://guides.rubyonrails.org/active_record_encryption.html

6. Securing Rails Applications. https://guides.rubyonrails.org/security.html


# CONTACT INFORMATION:
======================

For questions, issues, or feedback regarding this application:

- **Email:** b3nlamb3r7@gmail.com
- **GitHub:** TheLimitsOfYesterday
- **Course:** CS 4930/5930: Privacy and Censorship


# LICENSE:
==========

This project is created for educational purposes as part of coursework requirements.


---

**Last Updated:** October 2025
**Version:** 1.0.0
