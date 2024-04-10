from DatabaseLibrary import DatabaseLibrary

class CustomDBKeywords:

    def set_auto_commit_false(self):
        db_lib = DatabaseLibrary()
        connection = db_lib._cache.current
        connection.connection.set_auto_commit(False)