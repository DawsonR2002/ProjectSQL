package projects.dao;

import java.math.*;
import java.sql.*;
import java.util.List;

import projects.*;
import projects.entity.Project;
import projects.exception.DbException;
@SuppressWarnings("unused")
public class ProjectDao extends DaoBase {
	private static final String CATEGORY_TABLE = "category";
	private static final String MATERIAL_TABLE = "material";
	private static final String PROJECT_TABLE = "project";
	private static final String PROJECT_CATEGORY = "project_category";
	private static final String STEP_TABLE = "step";
	
	
	
	public Project insertProject(Project project) {
		
		
		String sql = "" + "INSERT INTO " + PROJECT_TABLE + " " 
				//			good													good
						+ "(project_name, estimated_hours, actual_hours, difficulty, notes) "
						+ "VALUES "
						+ "(?, ?, ?, ?, ?)";
		//System.out.println("test");
		try(Connection conn = DbConnection.getConnection()) {
			startTransaction(conn);
			
			try(PreparedStatement stmt = conn.prepareStatement(sql)){
				setParameter(stmt, 1, project.getProjectName(), String.class);
				setParameter(stmt, 2, project.getEstimatedHours(), BigDecimal.class);
				setParameter(stmt, 3, project.getActualHours(), BigDecimal.class);
				setParameter(stmt, 4, project.getDifficulty(), Integer.class);
				setParameter(stmt, 5, project.getNotes(), String.class);
				
				stmt.executeUpdate();
				
				
				
				Integer projectID = getLastInsertId(conn,PROJECT_TABLE);
				commitTransaction(conn);
				project.setProjectId(projectID);
				return project;
			}
			catch(Exception e) {
				rollbackTransaction(conn);
				throw new DbException(e);
			}
		}
		catch(Exception e) {
			throw new DbException(e);
		}
	}

	public void executeBatch(List<String> sqlBatch) {
    try (Connection conn = DbConnection.getConnection()) {
      startTransaction(conn);

      try (Statement stmt = conn.createStatement()) {
        /*
         * Add each SQL line to the Statement so they can be executed as a
         * batch.
         */
        for (String sql : sqlBatch) {
          stmt.addBatch(sql);
        }

        stmt.executeBatch();
        commitTransaction(conn);

      } catch (Exception e) {
        rollbackTransaction(conn);
        throw new DbException(e);
      }
    } catch (SQLException e) {
      throw new DbException(e);
    }
  }


}
