import yaml
import sys

class ConfEditor(object):

    def __init__(self, conf_location=None):
        self.conf_location = conf_location
        if conf_location is not None:
            self.conf = yaml.load(open(conf_location, 'r'))

    def _serialize(self):
        """
            Save dict to yaml file in same location
        """
        if self.conf_location is not None:
            with open(self.conf_location,'w') as handle:
                yaml.dump(self.conf, handle)

    def usage(self):
        return "Usage is %s [yaml_file] [create|read|update|append|delete] [key] (value)" % sys.argv[0]

    def create(self, key=None, value=None):
        """
            Create (or update) a key in the dictionary
        """
        if key is not None and value is not None:
            self.conf[key] = value
            self._serialize()
        else:
            raise Exception("Key and value must be specified")

    def read(self, key=None):
        """
            Return the value for a given key
        """
        if key is not None:
            if key in self.conf:
                return self.conf[key]
            else:
                return None
        else:
            raise Exception("Key must be specified")

    def update(self, key=None, value=None):
        """
            Calls create because the code is the same, not worth checking for missing/present keys
        """
        self.create(key=key, value=value)

    def append(self, key=None, value=None):
        """
            Append a value to a key, forces it into a list if it was not already.
        """
        if key is not None and value is not None:
            if key in self.conf and self.conf[key] is not None:
                if isinstance(self.conf[key], list):
                    # Append to existing lists
                    self.conf[key].append(value)
                else:
                    # Convert to a list
                    self.conf[key] = [
                        self.conf[key],
                        value
                    ]
            else:
                self.create(key=key,value=value)
            self._serialize()
        else:
            raise Exception("Key and value must be specified")

    def delete(self, key=None):
        """
            Remove a key from the dictionary
        """
        if key is not None:
            del self.conf[key]
            self._serialize()
        else:
            raise Exception("Key must be specified")

if __name__ == '__main__':
    p = sys.argv[1:]
    if len(p) < 2:
        ce = ConfEditor()
        print ce.usage()
        sys.exit(1)
    else:
        ce = ConfEditor(conf_location=p[0])
        command = p[1]
        if command == "create":
            ce.create(p[2], p[3])
        elif command == "read":
            val = ce.read(p[2])
            if val is not None:
                if isinstance(val, list):
                    for item in val:
                        print item
                else:
                    print item
        elif command == "update":
            ce.update(p[2], p[3])
        elif command == "append":
            ce.append(p[2], p[3])
        elif command == "delete":
            ce.delete(p[2])
        else:
            print ce.usage()
            sys.exit(1)
