import sys
import json
import re

def validate_payload(payload_path):
    with open(payload_path, 'r') as f:
        try:
            data = json.load(f)
        except json.JSONDecodeError as e:
            print(f"INVALID_JSON: {str(e)}")
            sys.exit(1)
    
    errors = []
    
    # 1. Structural Check (Matches createJiraIssue tool parameters)
    required_root_fields = ['cloudId', 'projectKey', 'issueTypeName', 'summary']
    for field in required_root_fields:
        if field not in data or not data[field]:
            errors.append(f"MISSING_REQUIRED_FIELD: Root field '{field}' is mandatory for createJiraIssue.")

    summary = data.get('summary', '')
    description = data.get('description', '')
    additional_fields = data.get('additional_fields', {})

    if not isinstance(additional_fields, dict):
        errors.append("INVALID_TYPE: 'additional_fields' must be a JSON object.")

    # 2. Platform Prefix Check
    valid_platforms = ['Android', 'iOS', 'Web', 'Backend']
    prefix_match = re.match(r'^\[(Android|iOS|Web|Backend)\]', summary)
    
    if not prefix_match:
        errors.append(f"MISSING_PLATFORM_PREFIX: Summary must start with one of {valid_platforms} in square brackets (e.g., [Android]).")
    
    # 3. Markdown Header Check
    if re.search(r'^\s*#+\s+', description, re.MULTILINE):
        errors.append("FORBIDDEN_HEADERS: Description contains Markdown headers (e.g., # Summary). Use *BOLD* labels instead.")
    
    # 4. Mobile Environment Check (Required if platform is Android or iOS)
    if prefix_match:
        platform = prefix_match.group(1)
        if platform in ['Android', 'iOS']:
            env_details = ["Device Model", "OS Version", "App Version"]
            missing = [detail for detail in env_details if detail not in description]
            if missing:
                errors.append(f"MISSING_MOBILE_DETAILS: Mobile bugs ({platform}) require: {', '.join(missing)} in the description.")

    if errors:
        for error in errors:
            print(error)
        sys.exit(1)
    else:
        print("VALIDATION_SUCCESS: Payload meets all structural and content requirements.")
        sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        validate_payload(sys.argv[1])
    else:
        print("ERROR: No payload file provided.")
        sys.exit(1)
