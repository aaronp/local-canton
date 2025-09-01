#!/bin/bash

echo "Setting up local Canton environment using DAML SDK..."

# Check if DAML is installed
if ! command -v daml &> /dev/null; then
    echo "DAML SDK not found. Installing DAML as per https://docs.daml.com/getting-started/installation.html"
    
    # Check if we're on macOS or Linux
    if [[ "$OSTYPE" == "darwin"* ]] || [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl -sSL https://get.daml.com/ | sh
        
        # Source the environment to make daml available
        export PATH="$HOME/.daml/bin:$PATH"
        
        if ! command -v daml &> /dev/null; then
            echo "DAML installation failed. Please install manually:"
            echo "https://docs.daml.com/getting-started/installation.html"
            exit 1
        fi
        
        echo "DAML SDK installed successfully!"
    else
        echo "Unsupported OS. Please install DAML SDK manually:"
        echo "https://docs.daml.com/getting-started/installation.html"
        exit 1
    fi
fi

echo "DAML SDK found: $(daml version)"

# Find Canton in DAML SDK
DAML_HOME="$HOME/.daml"

# Find the DAML version being used
DAML_VERSION=$(daml version | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | head -1)
if [ -z "$DAML_VERSION" ]; then
    DAML_VERSION="2.10.2"  # fallback
fi

CANTON_JAR="$DAML_HOME/sdk/$DAML_VERSION/canton/canton.jar"

if [ ! -f "$CANTON_JAR" ]; then
    echo "Canton JAR not found at: $CANTON_JAR"
    echo "Please ensure DAML SDK is properly installed."
    exit 1
fi

echo "Canton found at: $CANTON_JAR"

# Create a script to run canton
mkdir -p ./bin
cat > ./bin/canton << EOF
#!/bin/bash
exec java -jar "$CANTON_JAR" "\$@"
EOF
chmod +x ./bin/canton

# Create logs directory
mkdir -p ./logs

echo "Setup complete! Canton is ready."
echo "You can now start Canton with: ./start-local-canton.sh"