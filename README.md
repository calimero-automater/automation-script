# Calimero Node Setup

## Setup Instructions

1. **Save the Script**  
   Save the following script as `setup_calimero_node.sh`.

2. **Make the Script Executable**  
   Run the following command to make the script executable:  
   ```bash
   chmod +x setup_calimero_node.sh
   ```

3. **Execute the Script**  
   Run the script using:  
   ```bash
   ./setup_calimero_node.sh
   ```

## Notes

- **Protocol Specification**  
  - The `--protocol` flag defines which blockchain protocol will be used in the node context.  
  - The default protocol is **NEAR**, so this flag is not required if using NEAR.  
  - For other supported protocols, refer to the Calimero documentation.

- **Home Directory**  
  - The `--home` option specifies the directory for configuration and data.  
  - If not specified, the default location is `~/.calimero`.

- **Port Configuration**  
  - The `--server-port` and `--swarm-port` options allow you to specify custom ports for the server and swarm, respectively.  
  - Ensure that these ports are open and not in use by other applications.

